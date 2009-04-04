#!/usr/bin/env ruby
#
require 'date'
require 'rubygems'
require 'mechanize'
require 'yaml'
#require 'ruby-prof'

@threads = []

def threadit(url,n=nil)
  @threads << Thread.new {
    m = WWW::Mechanize.new
    m.user_agent_alias = 'Mac Safari'

    #p @threads
    x=n || "r-#{rand(100)}"
    puts "thread - #{x} STARTED - #{url}"
    begin
      title = m.get(url).title.strip
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

# u = []
# u << "http://www.google.com/"
# u << "http://www.yahoo.com/"
# u << "http://yellowpages.superpages.com/"
# u << "http://www.linux.org/"
# u << "http://netbsd.org/"
# u << "http://digg.com/"
# u << "http://msnbc.com/"
# u << "http://www.wikipedia.org/"
# u << "http://delicious.com/"
# u << "http://www.facebook.com/"
# u << "http://twitter.com/"


if not File.exist?(linkfile)
  puts "Can't find #{linkfile}"
  exit
end
u = YAML.load_file(linkfile)

# RubyProf.start

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
  threadit(u[n],n)
}


@threads.compact!
puts "what is in threads, #{@threads.inspect}, with size #{@threads.size}"
r=0
begin
  @threads.each {|t| t.join}
rescue NoMethodError
  puts "no method error caught"
end

end_t = Time.now
puts "\nEnded #{DateTime.parse(end_t.to_s)}"
puts "Total time in seconds - #{end_t-start_t}"

# result = RubyProf.stop
# 
# Print a flat profile to text
#printer = RubyProf::FlatPrinter.new(result)
#printer.print(STDOUT, 0)
#
# Print a graph profile to text
# printer = RubyProf::GraphPrinter.new(result)
# printer.print(STDOUT, 0)
