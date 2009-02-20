#!/usr/bin/env ruby

def n
  STDOUT.sync = true
  print '--->'
  gets
end

puts "Trying to require blah lib"
puts "require 'blah'"
n

begin
  require 'blah'
rescue LoadError => ex
  puts "WARNING: Unable to load library blah"
end

n
puts "Let's try to look at the script path"
puts <<'EOM'
script_path = File.expand_path(File.dirname(__FILE__))
EOM
script_path = File.expand_path(File.dirname(__FILE__))
puts "Script path maybe #{script_path}"
n

puts "Let's try to get the real path"
puts <<'EOM'
script_path = Dir.chdir(File.expand_path(File.dirname(__FILE__))) { Dir.pwd }
EOM
script_path = Dir.chdir(File.expand_path(File.dirname(__FILE__))) { Dir.pwd }
puts "Real script path #{script_path}"
n

puts "Now let's get the lib path and add to our lib path"
n
puts <<'EOM'
lib_path = Dir.chdir(script_path + '/../lib') { Dir.pwd }
$:.unshift lib_path
EOM
lib_path = Dir.chdir(script_path + '/../lib') { Dir.pwd }
$:.unshift lib_path
n

puts "Trying to require blah lib again"
puts "require 'blah'"
require 'blah'
n

puts "So here is what it takes to make all that work"
puts
puts <<'EOM'
script_path = Dir.chdir(File.expand_path(File.dirname(__FILE__))) { Dir.pwd }
lib_path = Dir.chdir(script_path + '/../lib') { Dir.pwd }
$:.unshift lib_path
EOM
