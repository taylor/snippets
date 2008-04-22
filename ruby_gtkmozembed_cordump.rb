require 'gtkmozembed'
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
