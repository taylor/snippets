%w[benchmark pp rubygems].each { |x| require x }
gem 'nokogiri', '>= 1.1.0'
require 'nokogiri'

##################################
# Parsing Delicious API Response #
##################################
xml = File.read('posts.xml')
puts Benchmark.measure {
  doc, posts = Nokogiri::XML(xml), []
  doc.xpath('//posts/post').each do |p|
    posts << p.attributes
  end
  # pp posts
}

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
