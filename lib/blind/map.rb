require_relative "element"
require "ray"

module Blind
  class Map
    def initialize(width, height)
      @width   = width
      @height  = height
      @objects = {}
    end

    def place(element, x, y)
      @objects[element] = [x, y]
    end

    def locate(element)
      Ray::Vector2.new(*@objects[element])
    end

    def move(element, dx, dy)
      x, y = @objects[element]
      @objects[element] = [x + dx, y + dy]
    end

    def collisions(element)
      (@objects.keys - [element]).select do |k|
        to_rect(element).collide?(to_rect(k))
      end
    end

    def nearest_boundary(element)
      pos = locate(element) 

      [(@width - pos.x) + element.width / 2,
        pos.x - (element.width / 2),
        (@height - pos.y) + element.height / 2,
        pos.y - (element.width / 2)].min
    end

    def within_bounds?(element)
      rect = to_rect(element)
      rect.inside?([0,0,@width,@height].to_rect)
    end

    private

    def to_rect(element)
      x, y = @objects[element]
      w, h = element.width, element.height

      [x-w/2,y-h/2, w, h].to_rect      
    end
  end
end
