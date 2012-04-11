require "ray"

module Blind
  class Map
    def place(*a)
    end

    def locate(name)
      Struct.new(:x,:y).new(10,25)
    end
  end
end
