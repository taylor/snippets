# Class to demonstrate send() and also a how a babies mind works.
class BabyBrain
  alias :rsleep :sleep
  def eat
    "gmmgmmm gmm. " + self.poop
  end
  def poop
   "Poop time!"
  end
  def help
    "Sleep. poop. eat"
  end
  def sleep
    puts "Zzzz..."
    rsleep 2
    "Oops I pooped"
  end
  def whoknows
    case rand(4)
    when 0
      self.poop
    when 1
      self.eat
    when 2
      self.sleep
    when 3
      self.cry
    end
  end
  def cry
    "waaaaa waaaa waaaa"
  end
end

puts "Greetings.  Welcome to the inner workings of a babies mind"
babybrain = BabyBrain.new
while 1
  print "What should I do now? "
  begin
    puts babybrain.send gets.strip.downcase
  rescue NoMethodError
    puts babybrain.whoknows
  rescue Interrupt
    puts babybrain.cry + " oops i pooped"
    exit
  end
end
