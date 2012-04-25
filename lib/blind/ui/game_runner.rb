require 'ray'

module Blind
  module UI
    class MainScene < Ray::Scene
      scene_name :main

      attr_accessor :game, :message, :mine_count

      def setup
        self.message = 
          "Find the phone, avoid the beeping mines and the sirens\n"+
          "(Use WASD keys to move)"
      end

      def register
        self.frames_per_second = 10

        always do
          if game.finished?
            self.message = game.game_over_message
          else
            game.detect_danger_zone
            
            game.move( 0.0, -0.2)  if holding?(:w) 
            game.move( 0.0,  0.2)  if holding?(:s)
            game.move(-0.2,  0.0)  if holding?(:a)
            game.move( 0.2,  0.0)  if holding?(:d)

            position = game.player_position

            Ray::Audio.pos = [position.x, position.y, 0]
          end
        end
      end

      def render(win)
        win.draw(text(message, :size => 20, :at => [30,30]))
        win.draw(text(game.to_s, :at => [30, 200])) if $DEBUG
      end
    end
    
    class GameRunner < Ray::Game
      def initialize
        super "Blind"

        MainScene.bind(self)

        scenes << :main
      end

      def register
        add_hook :quit, method(:exit!) 
      end
    end
  end
end
