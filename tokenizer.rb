#!/bin/ruby

require_relative 'clazz'
require_relative 'token'

class Tokenizer
  def initialize(path)
    if path != nil
      @clazzes = Tokenizer.load(path)
    end
  end

  def tokenize(str, remove_ws = false)
    if remove_ws == true then
      str = str.gsub(/[\s]/, "")
    end

    regex = "("

    @clazzes.each do |clazz|
      if regex.size == 1 then
        regex += clazz.regex
      else
        regex += "|" + clazz.regex
      end
    end

    regex += ")"
    index = 0

    tokens = []

    while index < str.length
      matches = /#{regex}/.match(str, index)
      
      if matches != nil
        captures = matches.named_captures.filter { |k, v| v != nil }

        captures.each do |k, v|
          @clazzes.each do |clazz|
            if clazz.name == "WS"
              index += v.length
              break
            elsif clazz.name == k
              index += v.length
              tokens << Token.new(clazz, v)
              break
            end
          end
        end
      end
    end

    return Stream.new(tokens)
  end

  def self.extract(str)
    match = str.match(/(\?\<[a-zA-Z_][a-zA-Z0-9_-]+\>)/)

    if !match.captures.empty?
      return "#{match.captures[0].gsub(/\?</, "").gsub(/>/, "")}"
    else
      return nil
    end
  end

  def self.load(path)
    clazzes = []

    File.open(path, "r") do |file|
      file.readlines.each do |line|
        clazzes << Clazz.new(Tokenizer.extract(line), line.strip)
      end
    end

    return clazzes
  end
end
