require "ray"

module Blind
  class Element
    def initialize(params)
      @name, @size = params.values_at(:name, :size)
    end

    # we want to position things by their centers
    def to_rect(x,y)
      [x - size/2.0, y - size/2.0, size, size].to_rect
    end
    
    attr_reader :name, :size
  end
end
