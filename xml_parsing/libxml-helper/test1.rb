require 'rubygems'
require 'libxml_helper'
require 'PP'

xmlfile = "t1.xml"
xml = File.read(xmlfile)
parser = XML::Parser.new
parser.string = xml

doc = parser.parse
doc.find('//a/b/c').each do |p|
  puts p.name
end




