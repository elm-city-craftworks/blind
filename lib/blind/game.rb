module Blind
  class Game
    def initialize(world)
      @world  = world 
      @events = Hash.new { |h,k| h[k] = ->() {} }
    end

    def move(dx, dy)
      x,y = world.current_position.to_a

      region = world.move_to(x + dx, y + dy)

      @events[:abyss_reached].call if region == :abyss
    end

    def on_event(name, &block)
      @events[name] = block
    end

    private

    attr_reader :world, :events
  end
end
