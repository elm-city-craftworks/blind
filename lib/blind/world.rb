require_relative "point"

module Blind
  class World
    class PointSet
      def initialize
        @points = []
      end

      def <<(point)
        @points << point
      end
    
      def first(label)
        @points.find { |point| point.label == label }
      end
  
      def all(label)
        @points.select { |point| point.label == label }
      end
    end

    def initialize
      @positions       = PointSet.new
      @regions         = []

      @reference_point = Point.new(0,0)
      @center_point    = Point.new(0,0)
    end

    attr_reader :reference_point, :center_point, :positions

    def add_region(label, minimum_distance)
      @regions << { :label => label, :minimum_distance => minimum_distance }
    end

    def add_position(label, position)
      position.label = label
      @positions << position
    end

    def region_at(point)
      distance = point.distance(center_point)

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
