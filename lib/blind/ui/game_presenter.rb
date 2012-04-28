require_relative "../world"
require_relative "../game"

require_relative "juke_box"

module Blind
  module UI
    class GamePresenter
      def initialize(levels)
        # FIXME: stopgap measure, should be non-destruction
        @levels        = Marshal.load(Marshal.dump(levels))
        load_new_level
      end

      attr_accessor :message, :current_level

      def load_new_level
        @current_level  = @levels.shift

        @world   = current_level.world
        @game    = Blind::Game.new(@world)
        @message = current_level.message   

        @sounds  = {}

        setup_sounds
        setup_events
      end

      def move(x,y)
        game.move(x,y)
      end

      def detect_danger_zone
        if in_danger_zone
          sounds[:siren].volume =  world.regional_depth * 100
        else
          sounds[:siren].volume = 0
        end
      end

      def to_s
        "Player position #{world.reference_point}\n"+
        "Region #{world.current_region}\n"+
        "Mines\n #{world.positions.all(:mine)
                        .each_slice(5)
                        .map { |e| e.join(", ") }.join("\n")}\n"+
        "Exit\n #{world.positions.first(:exit)}"
      end

      def player_position
        world.reference_point
      end

      def finished?
        finished
      end

      private

      def setup_sounds
        sounds[:phone]       = JukeBox.phone(@game.world.positions.first(:exit))
        sounds[:siren]       = JukeBox.siren
        sounds[:explosion]   = JukeBox.explosion
        sounds[:celebration] = JukeBox.celebration
        sounds[:mines]       = JukeBox.mines(@game.world.positions.all(:mine))
      end

      def setup_events
        game.on_event(:enter_region, :danger_zone) do
          self.in_danger_zone = true
        end

        game.on_event(:leave_region, :danger_zone) do
          self.in_danger_zone = false
        end

        game.on_event(:enter_region, :deep_space) do
          lose_game("You drifted off into deep space! YOU LOSE!")
        end

        game.on_event(:mine_detonated) do
          lose_game("You got blasted by a mine! YOU LOSE!")
        end

        game.on_event(:exit_located) do
          win_game("You found the exit! YOU WIN!")
        end
      end

      def lose_game(message)
        silence_sounds

        sound = sounds[:explosion]
        sound.play

        self.message  = message

        if @levels.empty?
          self.finished = true
        else
          load_new_level
        end
      end

      def win_game(message)
        silence_sounds

        sound = sounds[:celebration]
        sound.play

        self.message  = message

        if @levels.empty?
          self.finished = true
        else
          load_new_level
        end
      end

      def silence_sounds
        sounds.each do |name, sound|
          case name
          when :mines
            sound.each { |s| s.stop }
          else
            sound.stop
          end
        end
      end

      private 

      attr_accessor :in_danger_zone, :finished

      attr_reader :sounds, :world, :game
    end
  end
end
