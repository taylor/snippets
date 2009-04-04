#!/usr/bin/env ruby
#
require 'date'
require 'rubygems'
require 'mechanize'
require 'yaml'
require 'timeout'

@threads = []

def threadit(url,n=nil)
  @threads << Thread.new {
    m = WWW::Mechanize.new
    m.user_agent_alias = 'Mac Safari'
    title=''

    #p @threads
    x=n || "r-#{rand(100)}"
    puts "thread - #{x} STARTED - #{url}"
    begin
      Timeout::timeout(10) do
        title = m.get(url).title.strip
      end
    rescue Timeout::Error
      puts "Timed out trying to get url #{url}"
    rescue SocketError
      puts "Socket error for url #{url}...  maybe site now found?"
    rescue
      puts "exception in mech caught"
    end
    puts "thread #{x} DONE - #{url} title #{title}"
  }
end

linkfile=ARGV[0] || 'xlinks-run.yml'
ARGV.shift
totalthreads=ARGV[0] || 10
totalthreads=totalthreads.to_i
ARGV.shift

@choose_rand = ARGV[0].nil? ? false : true

if not File.exist?(linkfile)
  puts "Can't find #{linkfile}"
  exit
end
u = YAML.load_file(linkfile)


start_t = Time.now
start_dt = DateTime.parse(start_t.to_s)
puts "Threading #{totalthreads} times - starting #{start_dt}\n\n"
maxthreads=10
totalthreads.times { |n|
  loop_t = DateTime.now
  mtr=nil
  loop do
    @threads.delete_if {|t| t.status == false or t.status == nil }
    @threads.compact!

    break if @threads.size < maxthreads

    puts "max threads #{maxthreads} reached... waiting for some to stop" if mtr.nil?
    mtr=1
    if DateTime.now.min - loop_t.min > 10
      puts "It has taken more than 10 minutes! killing current threads..."
      #@threads.each {|t|t.kill}
      #@threads[0].kill
      puts "not"
    end

    #n=rand(10)+1
    #sleep n
  end
  url = @choose_rand ? u.choice : u[n]
  threadit(url,n)
}


@threads.compact!
@threads.each {|t| t.join}

end_t = Time.now
puts "\nEnded #{DateTime.parse(end_t.to_s)}"
puts "Total time in seconds - #{end_t-start_t}"
