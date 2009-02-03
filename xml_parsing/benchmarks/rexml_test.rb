%w[benchmark pp rexml/document].each { |x| require x }

##################################
# Parsing Delicious API Response #
##################################
xml = File.read('posts.xml')
puts Benchmark.measure {
  doc, posts = REXML::Document.new(xml), []
  doc.elements.each('posts/post') do |p|
    posts << p.attributes
  end
  # pp posts
}

################################
# Parsing Twitter API Response #
################################
xml = File.read('timeline.xml')
puts Benchmark.measure {
  doc, statuses = REXML::Document.new(xml), []
  doc.elements.each('statuses/status') do |s|
    h = {:user => {}}
    %w[created_at id text source truncated in_reply_to_status_id in_reply_to_user_id favorited].each do |a|
      h[a.intern] = s.elements[a].text
    end
    %w[id name screen_name location description profile_image_url url protected followers_count].each do |a|
      h[:user][a.intern] = s.elements['user'].elements[a].text
    end
    statuses << h
  end
  # pp statuses
}
