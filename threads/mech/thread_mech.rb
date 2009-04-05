#!/usr/bin/env ruby
#
require 'date'
require 'rubygems'
require 'mechanize'
require 'yaml'
require 'timeout'

@VERBOSE = ENV['VERBOSE'] ? true : false
@DEBUG = false

@threads = []

def threadit(url,n=nil)
  @threads << Thread.new {
    m = WWW::Mechanize.new
    m.user_agent_alias = 'Mac Safari'
    title=''

    #p @threads
    x=n || "r-#{rand(100)}"
    puts "thread - #{x} STARTED - #{url}" if @VERBOSE
    begin
      Timeout::timeout(10) do
        title = m.get(url).title.strip
      end
    rescue Timeout::Error
      puts "Timed out trying to get url #{url}" if @VERBOSE
    rescue SocketError
      puts "Socket error for url #{url}...  maybe site now found?" if @VERBOSE
    rescue
      puts "exception in mech caught" if @DEBUG
    end
    puts "thread #{x} DONE - #{url} title #{title}" if @VERBOSE
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
  mtr=nil
  loop do
    @threads.delete_if {|t| t.status == false or t.status == nil }
    @threads.compact!

    break if @threads.size < maxthreads

    puts "max threads #{maxthreads} reached... waiting for some to stop" if mtr.nil? and @VERBOSE
    mtr=1
  end
  url = @choose_rand ? u.choice : u[n]
  threadit(url,n)
}


@threads.compact!
@threads.each {|t| t.join}

end_t = Time.now
puts "\nEnded #{DateTime.parse(end_t.to_s)}"
puts "Total time in seconds - #{end_t-start_t}"
