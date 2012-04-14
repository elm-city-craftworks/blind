module Blind
  class Game
    def initialize(world)
      @world  = world
      @events = {}
    end

    def move(x,y)
      status = @world.move_player(x,y)

      event_handler = @events[status]
      event_handler.call if event_handler
    end

    def on_event(name, &block)
      @events[name] = block
    end
  end
end
