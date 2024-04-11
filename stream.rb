#!/bin/ruby

require_relative 'clazz'
require_relative 'token'

class Stream
  def initialize(path)
    @tokens = []
    @tokens_removed = []
    
    if path != nil
      @clazzes = Stream.load(path)
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
              @tokens << Token.new(clazz, v)
              break
            end
          end
        end
      end
    end
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
        clazzes << Clazz.new(Stream.extract(line), line.strip)
      end
    end

    return clazzes
  end

  def each
    @tokens.each do |token|
      yield token
    end
  end

  def has_curr
    @tokens.length > 0
  end

  def has_next
    @tokens.length > 1
  end

  def has_more
    @tokens.length > 2
  end

  def has_putback
    @tokens_removed.length > 0
  end

  def get_curr
    @tokens[0]
  end

  def get_next
    @tokens[1]
  end

  def get_more
    @tokens[2]
  end

  def get_last
    @tokens[-1]
  end

  def get_all
    @tokens
  end

  def get_all_removed
    @tokens_removed
  end

  def get_clazzes
    @clazzes
  end

  def rem_curr
    @tokens_removed << @tokens[0]
    return @tokens.shift
  end

  def rem_last
    @tokens_removed << @tokens[-1]
    return @tokens.pop
  end

  def put_back
    @tokens.prepend @tokens_removed[-1]
  end

  def length
    @tokens.length
  end

  def size
    @tokens.length
  end

  def empty?
    @tokens.empty?
  end

  def to_s
    "#{@tokens}"
  end
end
