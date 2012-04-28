require "ray"

require_relative "game_runner"
require_relative "../point"

module Blind
  module UI
    class Simulator
      def initialize(game)
        runner = Blind::UI::GameRunner.new

        @scene         = runner.registered_scene(:main)
        @scene.game    = game

        @scene.setup
        @scene.register


        @scene = scene
      end

      attr_reader :scene
      
      def move(x,y)
        if x > 0
          scene.window.input.press(Ray::Event::KeyD)
        elsif x < 0
          scene.window.input.press(Ray::Event::KeyA)
        end

        if y > 0
          scene.window.input.press(Ray::Event::KeyS)
        elsif y < 0
          scene.window.input.press(Ray::Event::KeyW)
        end

        original_level = scene.game.current_level

        while scene.game.player_position.distance(Blind::Point.new(x,y)) 
          if scene.game.current_level != original_level
            scene.window.input.release(Ray::Event::KeyD)
            scene.window.input.release(Ray::Event::KeyA)
            scene.window.input.release(Ray::Event::KeyW)
            scene.window.input.release(Ray::Event::KeyS)
            break
          elsif scene.game.finished?
            scene.run_tick
            break
          end

          if (scene.game.player_position.y - y).abs < 1
            scene.window.input.release(Ray::Event::KeyW)
            scene.window.input.release(Ray::Event::KeyS)
          end

          if (scene.game.player_position.x - x).abs < 1
            scene.window.input.release(Ray::Event::KeyD)
            scene.window.input.release(Ray::Event::KeyA)
          end

          scene.run_tick
        end
      end

      def status
        scene.game.message
      end
    end
  end
end
