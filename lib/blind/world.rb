require "ray"

require_relative "map"
require_relative "element"

module Blind
  class World
    def initialize(mine_count)
      @events = Hash.new { ->() {} }
      @map    = Blind::Map.new(100,100)         

      @player  = Blind::Element.new(:name => "player", :size => 1)


      @map[@player] = [rand(@player.size/2..100-@player.size/2),
                       rand(@player.size/2..100-@player.size/2)]

      @mines = (1..mine_count).map do |i|
        mine = Blind::Element.new(:name  => "mine #{i}", :size => 10)
        @map[mine] = [rand(mine.size/2..100-mine.size/2),
                      rand(mine.size/2..100-mine.size/2)]

        mine
      end

      @exit = Blind::Element.new(:name   => "exit", :size => 1)

      @map[@exit] = [ rand((@exit.size/2 + 20)..(100-@exit.size/2 - 20)),
                      rand((@exit.size/2 + 20)..(100-@exit.size/2 - 20))]
    end

    attr_reader :mines

    def exit_position
      @map[@exit]
    end

    def move_player(dx, dy)
      @map.move(@player, dx, dy)

      unless @map.within_bounds?(@player)
        @events[:out_of_bounds].call
      end

      if (@map.collisions(@player) & @mines).any?
        @events[:mine_collision].call
      end

      if @map.collisions(@player).include?(@exit)
        @events[:exit_located].call
      end
    end

    def escape_risk(margin_size)
      return 1 unless @map.within_bounds?(@player)
      return 0 if @map.nearest_boundary(@player) > margin_size
      
      1 - @map.nearest_boundary(@player) / margin_size.to_f
    end

    def mine_positions
      @mines.map { |m| @map[m] }
    end

    def player_position
      @map[@player]
    end

    def on_event(event_name, &block)
      @events[event_name] = block
    end
  end
end
