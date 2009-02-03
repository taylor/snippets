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
  puts "=== Examing node #{p.name} of class #{p.class} ==="
  p.each_element do |n|
    puts " --- Examing node #{n.name} of class #{n.class} ---"
    case n.name
    when "e" 
      puts " ** Content for #{n.name} #{n.first.content}"
      puts " --- Processing nodes for #{n.name}"
      n.each_element do |f|
        puts " *** Content for #{f.name} #{f.content}"
      end
    else
      puts " ** Content for #{n.name} #{n.content}"
    end
  end
end






