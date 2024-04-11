#!/bin/ruby

class Clazz
  attr_reader :name, :regex

  def initialize(name, regex)
    @name = name
    @regex = regex
  end

  def match?(str)
    str =~ /^#{regex}$/
  end
  
  def to_s()
    "#{@name} -> #{regex}"
  end
end
