require "matrix"

module Blind
  class Point
    def initialize(x,y)
      @data = Vector[x,y]
    end

    def x
      data[0]
    end

    def y
      data[1]
    end

    def distance(other)
      (self.data - other.data).r
    end

    def ==(other)
      distance(other).zero?
    end

    def to_a
      [x,y]
    end

    def to_s
      "(#{x}, #{y})"
    end

    protected
    
    attr_reader :data
  end
end
