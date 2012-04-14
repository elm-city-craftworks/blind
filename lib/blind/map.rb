require "ray"

module Blind
  class Map
    def initialize(width, height)
      @width   = width
      @height  = height
      @objects = {}
    end

    def []=(element, position)
      element.position  = position
      @objects[element] = position
    end

    def [](element)
      Ray::Vector2.new(*@objects[element])
    end

    def move(element, dx, dy)
      x, y = @objects[element]
      @objects[element] = element.position = [x + dx, y + dy]
    end

    def nearest_boundary(element)
      pos  = self[element]
      element.position = pos.to_a
      rect = element.to_rect

      top,    left  = rect.top_left.to_a
      bottom, right = rect.bottom_right.to_a

      [left, @width - right, top, @height - bottom].min
    end

    def within_bounds?(element)
      rect = to_rect(element)
      rect.inside?([0,0,@width,@height].to_rect)
    end

    private

    def to_rect(element)
      x, y = @objects[element]

      element.position = [x,y]
      element.to_rect
    end
  end
end
