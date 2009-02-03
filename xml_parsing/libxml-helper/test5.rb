require 'rubygems'
require 'libxml_helper'
require 'PP'

xmlfile = "t1.xml"
xml = File.read(xmlfile)
parser = XML::Parser.new
parser.string = xml

doc = parser.parse

#pp doc.find('//a/b/c').class

doc.find('//a/b/c').each do |p|
  puts "=== Examing node #{p.name} of class #{p.class} ==="
  p.each do |n|
    if n.text?
      puts "text --- #{n.content} ####"
    end
    puts " --- Examing node #{n.name} of class #{n.class} ---"
    case n.name
    when "e" 
      puts " ** Content for #{n.name} #{n.first.content}"
      puts " --- Processing nodes for #{n.name}"
      n.each_element do |f|
        pp f.next?
        puts " *** Content for #{f.name} #{f.content}"
      end
    else
      puts " ** Content for #{n.name} #{n.content}"
    end
  end
end
__END__
def proc_node(node=nil, il=0)
  puts "#{il} Examing node #{node.name} of class #{node.class} ==="
  if node.text?
    puts "#{il} Content is node.conent

  il = il+1
  node.each_element do |n|
    puts "#{il} Examing node #{node.name} of class #{node.class} ---"
    case n.name
    when "e"
    end


end

