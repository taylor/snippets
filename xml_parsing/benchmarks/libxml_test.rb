%w[benchmark pp rubygems].each { |x| require x }
gem 'libxml-ruby', '>= 0.8.3'
require 'xml'

##################################
# Parsing Delicious API Response #
##################################
xml = File.read('posts.xml')
puts Benchmark.measure {
  parser, parser.string = XML::Parser.new, xml
  doc, posts = parser.parse, []
  doc.find('//posts/post').each do |p|
    posts << p.attributes.inject({}) { |h, a| h[a.name] = a.value; h }
  end
  # pp posts
}

################################
# Parsing Twitter API Response #
################################
xml = File.read('timeline.xml')
puts Benchmark.measure {
  parser, parser.string = XML::Parser.new, xml
  doc, statuses = parser.parse, []
  doc.find('//statuses/status').each do |s|
    h = {:user => {}}
    %w[created_at id text source truncated in_reply_to_status_id in_reply_to_user_id favorited].each do |a|
      h[a.intern] = s.find(a).first.content
    end
    %w[id name screen_name location description profile_image_url url protected followers_count].each do |a|
      h[:user][a.intern] = s.find('user').first.find(a).first.content
    end
    statuses << h
  end
  # pp statuses
}
