script_path = Dir.chdir(File.expand_path(File.dirname(__FILE__))) { Dir.pwd }
lib_path = Dir.chdir(script_path + '/../lib') { Dir.pwd }
$:.unshift lib_path

## To handle all vendor libs use:
vendor_path = Dir.chdir(script_path + '/../vendor') { Dir.pwd }
Dir["#{vendor_path}/*/lib"].map { |l| $:.unshift(l) if File.directory?(l) }
