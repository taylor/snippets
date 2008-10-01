class String
	@@default_maxlen = 76

	# could do something with
	# 	newstring = string.split(/\s/).reverse.join(' ') # by word
	# possibly
	def split_line_by_word(maxlength=@@default_maxlen, *args)
		lines=Array.new
		i=0
		self.split.each { |w|
			if not lines[i].nil? and lines[i].length + w.length + 1 >= maxlength
				i += 1
			end

			if lines[i].nil?
				lines[i] = w
			else
				lines[i] += " " + w
			end
		}
		return lines
	end

	def split_line_by_character(maxlength=@@default_maxlen, *args)
		lines=Array.new
		i=0
		line=self.to_s
		while line.length > maxlength
			x=line.index("", maxlength - 4)
			lines[i] = line[0..x]
			line = line[(x+1)..-1]
			i += 1
		end
		return lines
	end

	def split_by_word(maxlength=@@default_maxlen, *args)
		return self.split_line_by_word(maxlength,args)
	end

	def split_by_char(maxlength=@@default_maxlen, *args)
		return self.split_line_by_character(maxlength,args)
	end

	def split_by_character(maxlength=@@default_maxlen, *args)
		return self.split_line_by_character(maxlength,args)
	end

	def split_line(maxlength=@@default_maxlen, type = "word", *args)
		if type == "character" or type == "char"
			return self.split_line_by_character(maxlength)
		else
			return self.split_line_by_word(maxlength)
		end
	end
end

__END__

s="Simple Ruby line splitter. The other day I needed to split up a large line into smaller ones before sending..., more outlined above allows you to specify what should happen"

puts "=== ORIGINAL  ==="
puts s
puts "=== NEW ==="
puts split_line(s, 760

