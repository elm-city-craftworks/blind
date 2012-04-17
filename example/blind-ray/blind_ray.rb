#!/usr/bin/env ruby 

require 'ray'

require_relative "lib/blind/ui/game_decorator"

# Optionally set the number of mines in the game.
# If an argument is not provided, the game will create 30 mines by default

if ARGV[0]
  num_mines = ARGV[0].to_i
  abort("Too many mines! Try 60 or fewer.") if num_mines > 60
else
  num_mines = 30
end

# Take care of some initial boilerplate for the game

game    = Blind::UI::GameDecorator.new(num_mines)
message = "Find the phone, avoid the beeping mines and the sirens\n"+
          "(Use WASD keys to move)"

Ray::Audio.pos = [0,0,0]

# Begin the actual Ray program. Most interesting work
# gets delegated to the Blind::UI::GameDecorator object

Ray.game "Blind" do
  register { add_hook :quit, method(:exit!) }

  scene :main do
    self.frames_per_second = 10

    add_hook :quit, method(:exit!)

    always do
      if game.finished?
        message = game.game_over_message
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
    
    render do |win|
      win.draw(text(message, :size => 20, :at => [30,30]))
      win.draw(text(game.to_s, :at => [30, 200])) if $DEBUG
     end
  end

  scenes << :main
end
