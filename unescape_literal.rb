require 'pp'

# Purpose: Unescape some characters from a string
#
# We are only dealing with the following charaters
#
#   \' – single quote
#   \" – double quote
#   \\ – single backslash
#   \a – bell/alert
#   \b – backspace
#   \r – carriage return
#   \n – newline
#   \s – space
#   \t – tab 
#
# Yes you can use eval instead if desired - eval('"' + str + '"')
# The point of this was avoiding the use of eval.  Why you ask?  Because if you
# just use something like the solution above you can be "attacked" with
# something like this
#
#   str = "" + system("evil system commands....") + ""

def unescape(str)
  str.gsub(/\\[\\'"abrnst]/) { |s|
     case s[1].chr
     when 'a'; "\a"
     when 'b'; "\b"
     when 'r'; "\r"
     when 'n'; "\n"
     when 's'; " "
     when 't'; "\t"
     else
       s[1].chr
     end 
  }
end

s='newline\nbell\adoublequote\"backslash\\backspace\bcarriagereturn\rspace\stab\tEND'
puts unescape(s)

s='newline\nnewline\nnewline'
puts s
puts unescape(s)

s='bells\abells\abells\a'
puts s
puts unescape(s)

s='doublequotes\"doublequotes'
puts s
puts unescape(s)

s="singlequote\\'singlequote\\'singlequote"
puts s
puts unescape(s)

s='space\sspace\sspace'
puts s
puts unescape(s)

s='backslash\\\\backslash'
puts s
puts unescape(s)
