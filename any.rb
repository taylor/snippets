# Extending any? functionality just for fun 
#
# New features:
#  * :odd and :even args will test for duh odd and even for any element
#  * The ability to pass multiple conditions to match on (logical OR. eg.
#    it stops on the first postive/true match otherwise falls thru to false).
#  * The ability to pass any type of closure not just implicity block
#  * Any other argument is treated like those to include?
# 
# The original idea was to try and add some of the look of ioke any?(odd?)
# See http://olabini.com/blog/2009/01/a-folding-language/
#
# For more fun with Ruby closures see
# See http://blog.sidu.in/2007/11/ruby-blocks-gotchas.html and 
# http://innig.net/software/ruby/closures-in-ruby.rb

module Enumerable
  begin
    [].oldany?
  rescue
    alias :oldany? :any?
  end
  def any? *args, &blk # bind the block because it will not be available to the original any? otherwise
    if args.empty?  # Ioke - [nil, false, "foo"] any? ; => true
      return self.oldany? &blk
    else
      args.each do |x|
        if x.class == Proc # Ioke - [1, 2, 3, 4] any?(x, x*x > 10)   ; => true
          return true if self.oldany? &x
        elsif x == :odd # Ioke - [1, 2, 3, 4] any?(odd?)  ; => true
          self.each {|n| next unless (n.class==Fixnum or n.class==Float); return true if n%2 == 1 }
        elsif x == :even
          self.each {|n| next unless (n.class==Fixnum or n.class==Float); return true if n%2 == 0 }
        else
          return true if self.include?(x)
        end
      end
    end
    return false
  end
end

# Acts like normal any?
[nil, false, "foo"].any?

# Acts like normal any? {..}
[1,2,3,4].any? {|n| n*n >5}

# Are any elements odd?
[1, 2, 3, 4].any?(:odd)
[2, 4, 6, 8].any?(:odd)

# Are any elements even?
[1, 2, 3, 4].any?(:even)
[1, 3, 5, 9].any?(:even)

# Can take a proc to decide true/false
# => true
[1, 2, 3, 4].any?(lambda {|x| x*x > 10})

# Defaults to include? for anything else
# => true, => false
[1,2,3,4].any?(1)
[1,2,3,4].any?(5)

# :odd and :even ignore non-Numbers (Fixnum and Float)
[nil, :sym, "string", 1].any?(:odd)

# Procs will have to deal with the elements themselves
[nil, :sym, "string", 1].any?(lambda {|x| x*x > 10}) rescue NoMethodError

# Pass multiple conditions
# => true, => true
[2,4,6,8].any?(:odd, :even)
[2,4,6,8].any?(:odd, lambda {|x| x/2 < 4})
[2,4,6,8].any?(:odd, lambda {|x| x*2 > 100}, :even)
