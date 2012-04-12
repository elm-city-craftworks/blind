require "ray"

module Blind
  class Game
    def initialize
      @events          = Hash.new { ->() {} }
      @player_position = Ray::Vector2.new(0,0)
    end

    attr_reader :player_position, :events

    def move_player(dx, dy)
      @player_position += [dx, dy] 

      if @player_position.x < 0 || @player_position.y < 0
        events[:out_of_bounds].call
      end
    end

    def on_event(event_name, &block)
      events[:out_of_bounds] = block
    end
  end
end
