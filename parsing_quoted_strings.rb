#!/usr/bin/env ruby

s = "a b \"c d\" e f 'g h' i"
p s

a = s.split(%r{["']([^"]*)["']|\s})
p a

a.delete("")
p a
