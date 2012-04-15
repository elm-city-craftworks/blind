module Blind
  class Game
    def initialize(world)
      @world  = world 
      @events = Hash.new { |h,k| h[k] = ->() {} }
    end

    def move(dx, dy)
      x,y = world.current_position.to_a

      r1 = world.current_region
      r2 = world.move_to(x + dx, y + dy) 

      if r1 != r2
        @events[[:leave_region, r1]].call
        @events[[:enter_region, r2]].call
      end

      mines = world.mine_positions

      if mines.find { |e| e.distance(world.current_position) < 5 }
        @events[[:mine_detonated]].call
      end

      if world.exit_position.distance(world.current_position) < 2
        @events[[:exit_located]].call
      end
    end

    def on_event(*event, &block)
      events[event] = block
    end

    private

    attr_reader :world, :events
  end
end
