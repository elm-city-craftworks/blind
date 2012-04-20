require "matrix"

module Blind
  class Point
    def self.random(distance_range)
      angle  = rand(0..2*Math::PI)
      length = rand(distance_range)

      x = length*Math.cos(angle)
      y = length*Math.sin(angle)

      Blind::Point.new(x.to_i,y.to_i)
    end

    def initialize(x,y)
      @data = Vector[x,y]
    end

    attr_accessor :label

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
