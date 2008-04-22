require 'gtkmozembed'

module Gtk
    # Thread-safety stuff.
    # Loosely based on booh, by Guillaume Cottenceau.

    PENDING_CALLS_MUTEX = Mutex.new
    PENDING_CALLS = []

    def self.thread_protect(&proc)
        if Thread.current == Thread.main
            proc.call
        else
            PENDING_CALLS_MUTEX.synchronize do
                PENDING_CALLS << proc
            end
        end
    end

    def self.thread_flush
        if PENDING_CALLS_MUTEX.try_lock
            for closure in PENDING_CALLS
                closure.call
            end
            PENDING_CALLS.clear
            PENDING_CALLS_MUTEX.unlock
        end
    end

    def self.init_thread_protect
        Gtk.timeout_add(100) do
            PENDING_CALLS_MUTEX.synchronize do
                for closure in PENDING_CALLS
                    closure.call
                end
                PENDING_CALLS.clear
            end
            true
        end
    end
end
Gtk.init_thread_protect

w = Gtk::Window.new
w.title = "Lean & mean browser"
w.resize(780, 570)
g = Gtk::MozEmbed.new
w << g
w.child.chrome_mask = Gtk::MozEmbed::ALLCHROME
w.child.location = "http://www.google.com/"
w.show_all

x = Thread.new { Gtk.main }

x.join
