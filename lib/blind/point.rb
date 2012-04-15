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

    protected
    
    attr_reader :data
  end
end
