#!/usr/bin/env ruby 

require 'ray'

require_relative "lib/blind/ui/game_decorator"

Ray.game "Blind" do
  if ARGV[0]
    num_mines = ARGV[0].to_i
    abort("Too many mines! Try 60 or fewer.") if num_mines > 60
  else
    num_mines = 30
  end

  game    = Blind::UI::GameDecorator.new(num_mines)
  message = "Find the phone, avoid the beeping mines and the sirens"

  register { add_hook :quit, method(:exit!) }

  scene :main do
    self.frames_per_second = 10

    add_hook :quit, method(:exit!)

    Ray::Audio.pos = [0,0,0]

    always do
      if game.finished?
        message = game.game_over_message
      else
        game.detect_danger_zone
        
        game.move(0,-0.2)  if holding?(:w) 
        game.move(0 ,0.2)  if holding?(:s)
        game.move(-0.2, 0)  if holding?(:a)
        game.move(0.2,  0)  if holding?(:d)

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
