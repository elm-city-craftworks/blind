require_relative "point"

module Blind
  class World
    def initialize
      @center = Blind::Point.new(0,0) 
      @current_position = Blind::Point.new(0,0)
    end

    attr_reader :current_position

    def move_to(x,y)
      @current_position = Blind::Point.new(x,y)
      current_region
    end

    def current_region
      case @current_position.distance(@center)
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
