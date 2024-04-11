#!/bin/ruby

class Stream
  def initialize(tokens)
    @tokens = tokens
    @tokens_removed = []
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
