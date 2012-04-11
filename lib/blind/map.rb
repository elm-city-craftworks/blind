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

    def move(name, x,y)
      xo, yo = @objects[name]
      @objects[name] = [xo + x, yo + y]
    end
  end
end
