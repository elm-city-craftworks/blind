require_relative "point"

module Blind
  class World
    SAFE_ZONE_RANGE   = 0...20
    MINE_FIELD_RANGE  = 20...100
    DANGER_ZONE_RANGE = 100...120

    def initialize(mine_count)
      @center           = Blind::Point.new(0,0) 
      @current_position = Blind::Point.new(0,0)

      @mine_positions   = mine_count.times.map do
        Blind::Point.new(rand(MINE_FIELD_RANGE), rand(MINE_FIELD_RANGE))
      end

      @exit_position = 
        Blind::Point.new(rand(MINE_FIELD_RANGE), rand(MINE_FIELD_RANGE))
    end

    attr_reader :current_position, :mine_positions, :exit_position

    def distance(other)
      @current_position.distance(other)
    end

    def move_to(x,y)
      @current_position = Blind::Point.new(x,y)

      current_region
    end

    def current_region
      case @current_position.distance(@center)
      when SAFE_ZONE_RANGE
        :safe_zone
      when MINE_FIELD_RANGE
        :mine_field
      when DANGER_ZONE_RANGE
        :danger_zone
      else
        :outer_rim
      end
    end
  end
end
