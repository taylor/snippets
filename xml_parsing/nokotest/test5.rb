require 'rubygems'
#gem 'nokogiri', '>= 1.1.0'
require 'nokogiri'
require 'PP'

xmlfile = "t2.xml"
xml = File.read(xmlfile)
doc = Nokogiri::XML(xml)
cees = []
doc.xpath('//a/b/c').each do |c|
  h = {:e =>{}}
  h[:d] = c.at('d').text
  h[:e][:e_text] = c.at('e').child.text
  h[:e][:f] = []
  c.at("e").children.each do |e|
    if e.type == 1
      h[:e][:f] << e.text
    end
  end
  cees << h
end

puts cees.inspect
