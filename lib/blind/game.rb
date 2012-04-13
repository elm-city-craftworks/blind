require "ray"

require_relative "map"
require_relative "element"

module Blind
  class Game
    def initialize
      @events = Hash.new { ->() {} }
      @map    = Blind::Map.new(100,100)         

      @player  = Blind::Element.new(:name   => "player",
                                    :width  => 10,
                                    :height => 10)

      @map.place(@player, rand(@player.width/2..100-@player.width/2),
                          rand(@player.height/2..100-@player.height/2))

      @mines = (1..5).map do |i|
        mine = Blind::Element.new(:name   => "mine #{i}",
                                  :width  => 10,
                                  :height => 10)
        @map.place(mine, rand(mine.width/2..100-mine.width/2),
                         rand(mine.height/2..100-mine.height/2))

        mine
      end
    end

    attr_reader :mines

    def move_player(dx, dy, sigil=false)
      @map.move(@player, dx, dy)

      unless @map.within_bounds?(@player)
        @events[:out_of_bounds].call
      end

      if @map.collisions(@player).any?
        @events[:mine_collision].call
      end
    end

    def escape_risk(margin_size)
      return 1 unless @map.within_bounds?(@player)
      return 0 if @map.nearest_boundary(@player) > margin_size
      
      1 - @map.nearest_boundary(@player) / margin_size.to_f
    end

    def mine_positions
      @mines.map { |m| @map.locate(m) }
    end

    def player_position
      @map.locate(@player)
    end

    def on_event(event_name, &block)
      @events[event_name] = block
    end
  end
end
