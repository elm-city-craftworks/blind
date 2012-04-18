require "ray"

module Blind
  module UI
    JukeBox = Object.new
    
    class << JukeBox 
      def siren
        new_sound("horn") do |s|
          s.looping = true
          s.volume  = 0

          s.play
        end
      end

      def explosion
        new_sound("grenade")
      end

      def phone(position)
        new_sound("telephone") do |s|
          s.pos     = [position.x, position.y, 0]
          s.looping = true

          s.play
        end
      end

      def celebration
        new_sound("win")
      end

      def mines(positions)
        step      = 0
        step_size = 1/positions.count.to_f

        positions.map do |pos|
          new_sound("beep") do |s|
            s.pos     = [pos.x, pos.y, 1]
            s.looping = true
            s.pitch   = step + rand(step_size)

            s.play

            step += step_size
          end
        end
      end

      private

      def new_sound(name) 
        filename = "#{File.dirname(__FILE__)}/../../../data/#{name}.wav"
        
        Ray::Sound.new(filename).tap do |s|
          yield s if block_given?
        end
      end
    end
  end
end
