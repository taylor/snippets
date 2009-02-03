require 'rubygems'
require 'rexml/document'

xml = File.read('amazon_sample.xml')
#puts xml

items = []

doc = REXML::Document.new(xml)
doc.elements.each('/ItemSearchResponse/Items') do |e|
  items << e.text
end

items.each { |i|
  puts i
}


