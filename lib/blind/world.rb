require_relative "point"

module Blind
  class World
    # TODO: FIX THIS STOPGAP MEASURE 
    MINEFIELD_RANGE = 20...100

    def self.standard(mine_count)
      Blind::World.new(5).tap do |w|
        w.add_region(:safe_zone,     0)
        w.add_region(:mine_field,   20)
        w.add_region(:danger_zone, 100)
        w.add_region(:deep_space,  120)
      end
    end

    def initialize(mine_count)
      @center_position  = Blind::Point.new(0,0) 
      @current_position = Blind::Point.new(0,0)

      @mine_positions   = mine_count.times.map do
        random_position(MINEFIELD_RANGE)
      end

      @exit_position = random_position(MINEFIELD_RANGE)

      @regions = []
    end

    attr_reader :center_position, :current_position, 
                :mine_positions,  :exit_position


    def add_region(name, minimum_distance)
      @regions << { :name => name, :minimum_distance => minimum_distance }
    end

    def region_at(point)
      distance = point.distance(center_position)

      @regions.select { |r| distance >= r[:minimum_distance] }
              .max_by { |r| r[:minimum_distance] }
              .fetch(:name)
    end

    def distance(other)
      current_position.distance(other)
    end

    def move_to(x,y)
      self.current_position = Blind::Point.new(x,y)

      current_region
    end

    def current_region
      region_at(current_position)
    end

    private

    attr_writer :current_position
    
    def random_position(distance_range)
      angle  = rand(0..2*Math::PI)
      length = rand(distance_range)

      x = length*Math.cos(angle)
      y = length*Math.sin(angle)

      Blind::Point.new(x.to_i,y.to_i)
    end
  end
end
