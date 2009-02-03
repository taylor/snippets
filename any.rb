#
# http://olabini.com/blog/2009/01/a-folding-language/
class Array
  begin
    [].oldany?
  rescue
    alias :oldany? :any?
  end
  def any? *args
    if args.empty?  # [nil, false, "foo"] any? ; => true
      self.oldany?
    elsif args.include?(:odd) # [1, 2, 3, 4] any?(odd?)  ; => true
      self.each {|n| return true if n%2 == 1 }
      return false
    elsif args.include?(:even)
      self.each {|n| return true if n%2 == 0 }
      return false
    elsif args[0].class == Proc # [1, 2, 3, 4] any?(x, x*x > 10)   ; => true
      self.each {|n| return true if args[0].call(n)}
      return false
    else
      #raise "Invalid Argument"
      return nil
    end
  end
end

a = [nil, false, "foo"]
a.any?

a = [1, 2, 3, 4]
a.any?(:odd)
a = [2, 4, 6, 8]
a.any?(:odd)

a = [1, 2, 3, 4]
a.any?(:even)
a = [1, 3, 5, 9]
a.any?(:even)

# [1, 2, 3, 4] any?(x, x*x > 10)   ; => true
a = [1, 5, 20, 15]
a.any?(lambda {|x| return x > 40})

[1,2,3,4].any?(1)
