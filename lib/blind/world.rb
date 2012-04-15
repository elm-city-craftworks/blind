require_relative "point"

# possibly refactor to be a simple lookup
# rather than doing point manipulation

module Blind
  class World
    def initialize
      @center = Blind::Point.new(0,0) 
    end

    def region(point)
      case point.distance(@center)
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
