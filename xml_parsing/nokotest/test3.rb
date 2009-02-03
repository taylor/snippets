require 'rubygems'
#gem 'nokogiri', '>= 1.1.0'
require 'nokogiri'
require 'PP'

xmlfile = "t.xml"
xml = File.read(xmlfile)
doc = Nokogiri::XML(xml)
doc.xpath('//a/b/c/*').each do |p|
  puts "---"
  pp p.name
  pp p.class
  pp p.text
  p.children.each do |n|
    puts "---"
    pp n.name
    pp n.class
    pp n.text
  end
  #pp (p/).text
  #puts p.class
end
#
__END__

################################
# Parsing Twitter API Response #
################################
xml = File.read('timeline.xml')
puts Benchmark.measure {
  doc, statuses = Nokogiri::XML(xml), []
  doc.xpath('//statuses/status').each do |s|
    h = {:user => {}}
    %w[created_at id text source truncated in_reply_to_status_id in_reply_to_user_id favorited].each do |a|
      h[a.intern] = s.at(a).text
    end
    %w[id name screen_name location description profile_image_url url protected followers_count].each do |a|
      h[:user][a.intern] = s.at('user').at(a).text
    end
    statuses << h
  end
  # pp statuses
}
