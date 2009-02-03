require 'rubygems'
require 'libxml_helper'
require 'PP'

xmlfile = "t2.xml"
xml = File.read(xmlfile)
parser = XML::Parser.new
parser.string = xml

doc = parser.parse

#pp doc.find('//a/b/c').class

doc.find('//a/b/c').each do |p|
  puts "TACO"
  puts p.class
  puts p.name
  if p.name == "text"
    puts "content #{p.content}"
  end
  p.each do |n|
    puts " #{n.name}"
      puts " content #{n.content}"
    puts " #{n.class}"
    if n.name == "text"
      puts " content #{n.content}"
    end
  end
end




