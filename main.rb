#!/usr/bin/ruby

require_relative 'stream'

stream = Stream.new("math.clazz")

str = "y = 10x - 5"

stream.tokenize(str)

i = 0
stream.each do |x|
  puts "#{x.clazz} -> #{x.lexeme}"
  i += 1
end
