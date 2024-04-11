#!/bin/ruby

class Token
  attr_reader :clazz, :lexeme

  def initialize(clazz, lexeme)
    @clazz = clazz
    @lexeme = lexeme
  end

  def to_s()
    "[#{@clazz}] -> '#{@lexeme}'"
  end
end
