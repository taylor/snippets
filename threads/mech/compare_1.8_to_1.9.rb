require 'yaml'
u = YAML.load_file('xlinks.yml')

totalu=ARGV[0] || 10
totalu=totalu.to_i
ARGV.shift

nu = []
totalu.times {|n| nu[n] = u[rand(u.size-1)] }

linksfile="xlinks-run.yml"
f = File.new(linksfile, "w")

f.puts nu.to_yaml
f.close

r1_8="ruby"
r1_9="ruby1.9"
prog="thread_mech.rb"
puts "Running #{r1_8} #{prog} #{linksfile} #{totalu}"
t18s=Time.now
system("#{r1_8} #{prog} #{linksfile} #{totalu}")
t18e=Time.now
puts "Running #{r1_9} #{prog} #{linksfile} #{totalu}"
t19s=Time.now
system("#{r1_9} #{prog} #{linksfile} #{totalu}")
t19e=Time.now

puts "1.8 took #{t18e-t18s} seconds"
puts "1.9 took #{t19e-t19s} seconds"
