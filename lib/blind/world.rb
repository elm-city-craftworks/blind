require_relative "point"

module Blind
  class World
    # TODO: FIX THIS STOPGAP MEASURE 
    MINEFIELD_RANGE = 20...100

    def self.standard(mine_count)
      Blind::World.new.tap do |w|
        w.add_region(:safe_zone,     0)
        w.add_region(:mine_field,   20)
        w.add_region(:danger_zone, 100)
        w.add_region(:deep_space,  120)

        w.add_position(:center, Blind::Point.new(0,0))

        mine_count.times do 
          w.add_position(:mine, Blind::Point.random(MINEFIELD_RANGE))
        end

        w.add_position(:exit, Blind::Point.random(MINEFIELD_RANGE))
      end
    end

    def initialize
      @positions       = []
      @regions         = []

      @reference_point = Blind::Point.new(0,0)
    end

    attr_reader :reference_point

    def center_position
      @positions.find { |pos| pos[:label] == :center }[:location]
    end

    def exit_position
      @positions.find { |pos| pos[:label] == :exit }[:location]
    end

    def mine_positions
      @positions.select { |pos| pos[:label] == :mine }.map { |e| e[:location] }
    end

    def add_region(label, minimum_distance)
      @regions << { :label => label, :minimum_distance => minimum_distance }
    end

    def add_position(label, location)
      @positions << { :label => label, :location => location }
    end

    def region_at(point)
      distance = point.distance(center_position)

      @regions.select { |r| distance >= r[:minimum_distance] }
              .max_by { |r| r[:minimum_distance] }
              .fetch(:label)
    end

    def distance(other)
      reference_point.distance(other)
    end

    def move_to(x,y)
      self.reference_point = Blind::Point.new(x,y)

      current_region
    end

    def current_region
      region_at(reference_point)
    end

    private

    attr_writer :reference_point
  end
end
