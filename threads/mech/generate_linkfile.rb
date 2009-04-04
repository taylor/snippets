require 'rubygems'
require 'scrubyt'
require 'yaml'

@dict='/usr/share/dict/words'

def rand_word
  w=nil
  puts "looking for random word"
  lines=File.readlines(@dict)
  lines.each_with_index do |l,i|
    if i == rand(lines.size)
      w=l
      break
    end
  end
  w
end

words=['ruby', 'beer', 'jelly', 'austin', 'monkey', 'cat', 'burrito']
q=ARGV[0] || rand_word || words[rand(words.size-1)]

google_data = Scrubyt::Extractor.define do
  fetch "http://www.google.com/search?hl=en&q=#{q}"

    link_title "//a[@class='l']", :write_text => true do
    link_url
    end
end

linkfile='xlinks.yml'
g = google_data.to_hash
links = YAML.load_file(linkfile)
links = [] unless links
links += g.collect {|l| l[:link_url].match(/(http:\/\/[^\/]*)/); $1}.uniq

y=File.new(linkfile, "w")
puts links.to_yaml
y.puts links.to_yaml
y.close
