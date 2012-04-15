require_relative "point"

module Blind
  class World
    def initialize
      @center = Blind::Point.new(0,0) 
      @player = Blind::Point.new(0,0)
    end

    def move_to(x,y)
      @player = Blind::Point.new(x,y)
    end

    def current_region
      case @player.distance(@center)
      when 0...20
        :safe_zone
      when 20...100
        :mine_field
      when 100...120
        :danger_zone
      else
        :outer_rim
      end
    end
  end
end
