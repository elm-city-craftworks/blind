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
    end

    def on_event(*event, &block)
      @events[event] = block
    end

    private

    attr_reader :world, :events
  end
end
