require_relative "../lib/blind/world"

module Blind
  module Worlds
    def self.original(mine_count)
      Blind::World.new.tap do |w|
        minefield_range = 20...100

        w.add_region(:safe_zone,     0)
        w.add_region(:mine_field,   20)
        w.add_region(:danger_zone, 100)
        w.add_region(:deep_space,  120)

        mine_count.times do 
          w.add_position(:mine, Blind::Point.random(minefield_range))
        end

        w.add_position(:exit, Blind::Point.random(minefield_range))
      end
    end

    def self.cramped(mine_count)
      Blind::World.new.tap do |w|
        minefield_range = 15...75

        w.add_region(:safe_zone,     0)
        w.add_region(:mine_field,   15)
        w.add_region(:danger_zone,  75)
        w.add_region(:deep_space,   80)

        mine_count.times do 
          w.add_position(:mine, Blind::Point.random(minefield_range))
        end

        w.add_position(:exit, Blind::Point.random(minefield_range))
      end
    end


    def self.trivial(mine_count)
      Blind::World.new.tap do |w|
        w.add_region(:safe_zone,    0)
        w.add_region(:mine_field,  10)
        w.add_region(:danger_zone, 20)
        w.add_region(:deep_space,  30)
        
        w.add_position(:exit, Blind::Point.random(10...20))
      end
    end
  end
end
