class NilClass
	def length
		self.to_s.length
	end
	def empty?
		self.to_s.empty?
	end

	def <<(*args)
		puts "self #{self}"
		r=nil
		args.each {|a|
			if r.nil?
				r=a
			else
				case a.class
				when String
					if r.class == String
						r << " " + a
					elsif r.class == Array
						r << a
					else
						raise ArgumentError
					end
				when Array
					if r.class == String
						r << a.join(" ")
					elsif r.class == Array
						r += a
					else
						raise ArgumentError
					end
				else
					raise ArgumentError
				end
			end
		}
		#self = r
		#self
		r
	end
end
