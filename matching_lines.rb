# Printing only matching lines
 
s="john smith\nalice pena\nroot\nbob living\ntammy baroot\ncats"
q="root"
puts "Matching #{q} in: #{s.inspect}"
s.each {|x| next unless x =~ /#{q}/ ; puts "* #{x}" }
 
puts

# Create a new multi-line string w/only matching lines
s="abc\nlots of girls\nfat chickens\ngirls everywhere\nmeetings\ntaco\ngirl in bikini\ncats"
q="girl"
puts "Creating new multi-line string w/only lines matching '#{q}' from\n\t#{s.inspect}"
ns = s.split("\n").map {|x| next unless x =~ /#{q}/; x}.compact.join("\n")
puts "New string: #{ns.inspect}"
