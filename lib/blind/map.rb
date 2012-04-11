module Blind
  class Map
    Location = Struct.new(:x, :y)

    def initialize(width, height)
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
      true
    end
  end
end
