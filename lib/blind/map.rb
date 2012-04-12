require_relative "element"

module Blind
  class Map
    Location = Struct.new(:x, :y)

    def initialize(width, length)
      @width   = width
      @length  = length
      @objects = {}
    end

    def place(name, x, y)
      @objects[name] = [x,y]
    end

    def locate(name)
      Location.new(*@objects[name])
    end

    def move(name, dx, dy)
      x, y = @objects[name]
      @objects[name] = [x + dx, y + dy]
    end

    def within_bounds?(name)
      x, y = @objects[name]

      (0..@width).include?(x) && (0..@length).include?(y)
    end
  end
end
