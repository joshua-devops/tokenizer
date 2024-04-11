#!/usr/bin/ruby

require_relative 'tokenizer'
require_relative 'stream'

tok = Tokenizer.new("math.clazz")

str = "y = 10x - 5"

stream = tok.tokenize(str)

i = 0
stream.each do |x|
  puts "#{x.clazz.name} -> #{x.lexeme}"
  i += 1
end
