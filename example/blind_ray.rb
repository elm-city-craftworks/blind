#!/usr/bin/env ruby

$VERBOSE=false

require 'ray'
require_relative "../lib/blind/game"
require_relative "../lib/blind/world"

Ray.game "Blind" do
  register { add_hook :quit, method(:exit!) }

  scene :main do
    self.frames_per_second = 20

    world = Blind::World.new(40)
    game  = Blind::Game.new(world)


    horn = sound("#{File.dirname(__FILE__)}/data/horn.wav")
    horn.play
    horn.looping = true

    horn.volume = 0


    step = 0.025
    
    mines = world.mine_positions.map do |pos| 
      s          = sound("#{File.dirname(__FILE__)}/data/beep.wav")
      s.pos      = [pos.x, pos.y, 1]
      s.looping  = true
      s.pitch    = step + rand(0.025)
      step += 0.025

      s.play

      s
    end

    grenade = sound("#{File.dirname(__FILE__)}/data/grenade.wav")

    win = sound("#{File.dirname(__FILE__)}/data/win.wav")

    phone = sound("#{File.dirname(__FILE__)}/data/telephone.wav")
    phone.pos = [world.exit_position.x, world.exit_position.y, 1]
    phone.looping = true
    phone.play
    
    game.on_event(:enter_region, :danger_zone) do
      @in_danger_zone = true
    end

    game.on_event(:leave_region, :danger_zone) { 
      @in_danger_zone = false
    }

    game.on_event(:enter_region, :outer_rim) do
      phone.stop
      mines.each { |e| e.stop }

      grenade.play
      sleep grenade.duration
      exit!
    end

    game.on_event(:mine_detonated) do
      phone.stop
      mines.each { |e| e.stop }

      grenade.pitch = 1.5
      grenade.play
      sleep grenade.duration
      exit!
    end

    game.on_event(:exit_located) do
      phone.stop
      mines.each { |e| e.stop }

      win.play
      sleep win.duration
      exit!
    end

    always do
     if @in_danger_zone
       horn.volume = ((world.distance(world.center_position) - 100) / 120.0) * 100
     end

      game.move(0,-0.2)  if holding?(:w) 
      game.move(0 ,0.2)  if holding?(:s)
      game.move(-0.2, 0)  if holding?(:a)
      game.move(0.2,  0)  if holding?(:d)

      Ray::Audio.pos = [world.current_position.x, world.current_position.y, 0]
    end
    
    render do |win|
      if $DEBUG
        win.draw text("Player position #{world.current_position}\n"+
                      "Region #{world.current_region}\n"+
                      "Mines\n #{world.mine_positions.each_slice(10).map { |e| e.join(", ") }.join("\n")}\n"+
                      "Exit\n #{world.exit_position}")
      end
    end
  end

  scenes << :main
end
