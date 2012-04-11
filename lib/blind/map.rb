module Blind
  class Map
    Location = Struct.new(:x, :y)

    def initialize
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
  end
end
