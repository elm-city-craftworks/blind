require_relative "point"

module Blind
  class World
    SAFE_ZONE_RANGE   = 0...20
    MINE_FIELD_RANGE  = 20...100
    DANGER_ZONE_RANGE = 100...120

    def initialize(mine_count)
      @center_position  = Blind::Point.new(0,0) 
      @current_position = Blind::Point.new(0,0)

      @mine_positions   = mine_count.times.map do
        random_minefield_position
      end

      @exit_position = random_minefield_position
    end

    attr_reader :center_position, :current_position, 
                :mine_positions,  :exit_position

    def distance(other)
      @current_position.distance(other)
    end

    def move_to(x,y)
      @current_position = Blind::Point.new(x,y)

      current_region
    end

    def current_region
      case @current_position.distance(center_position)
      when SAFE_ZONE_RANGE
        :safe_zone
      when MINE_FIELD_RANGE
        :mine_field
      when DANGER_ZONE_RANGE
        :danger_zone
      else
        :deep_space
      end
    end

    private
    
    def random_minefield_position
      angle  = rand(0..2*Math::PI)
      length = rand(MINE_FIELD_RANGE)

      x = length*Math.cos(angle)
      y = length*Math.sin(angle)

      Blind::Point.new(x.to_i,y.to_i)
    end
  end
end
