require_relative "element"
require "ray"

module Blind
  class Map
    Location = Struct.new(:x, :y)

    def initialize(width, height)
      @width   = width
      @height  = height
      @objects = {}
    end

    def place(element, x, y)
      @objects[element] = x,y
    end

    def locate(element)
      Location.new(*@objects[element])
    end

    def move(element, dx, dy)
      x, y = @objects[element]
      @objects[element] = [x + dx, y + dy]
    end

    def within_bounds?(element)
      x, y = @objects[element]
      w, h = element.width, element.height

      rect = [x-w/2,y-h/2, w, h].to_rect

      rect.inside?([0,0,@width,@height].to_rect)
    end
  end
end
