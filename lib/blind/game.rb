module Blind
  class Game
    def initialize(world)
      @world  = world 
      @events = Hash.new { |h,k| h[k] = ->() {} }
    end

    def move(dx, dy)
      x,y = world.current_position.to_a

      r1  = world.current_region
      r2  = world.move_to(x + dx, y + dy) 

      if r1 != r2
        broadcast_event(:leave_region, r1)
        broadcast_event(:enter_region, r2)
      end

      mines = world.mine_positions

      if mines.find { |e| world.distance(e) < 5 }
        broadcast_event(:mine_detonated)
      end

      if world.distance(world.exit_position) < 2
        broadcast_event(:exit_located)
      end
    end

    def on_event(*event, &block)
      events[event] = block
    end

    private

    def broadcast_event(*args)
      @events[args].call
    end

    attr_reader :world, :events
  end
end
