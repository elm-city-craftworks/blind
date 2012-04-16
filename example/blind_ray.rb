#!/usr/bin/env ruby

$VERBOSE=false

require 'ray'
require_relative "../lib/blind/game"
require_relative "../lib/blind/world"

Ray.game "Blind" do
  register { add_hook :quit, method(:exit!) }

  scene :main do
    self.frames_per_second = 20

    world = Blind::World.new(20)
    game  = Blind::Game.new(world)


    horn = sound("#{File.dirname(__FILE__)}/data/horn.wav")
    horn.play
    horn.looping = true

    horn.volume = 0


    step = 0.04
    
    mines = world.mine_positions.map do |pos| 
      s          = sound("#{File.dirname(__FILE__)}/data/beep.wav")
      s.pos      = [pos.x, pos.y, 1]
      s.looping  = true
      s.pitch    = step + rand(0.05)
      step += 0.05

      s.play

      s
    end

    grenade = sound("#{File.dirname(__FILE__)}/data/grenade.wav")

    win = sound("#{File.dirname(__FILE__)}/data/win.wav")
    
    game.on_event(:enter_region, :danger_zone) { horn.volume = 100 }
    game.on_event(:leave_region, :danger_zone) { horn.volume = 0 }

    game.on_event(:enter_region, :outer_rim) do
      mines.each { |e| e.stop }

      grenade.play
      sleep grenade.duration
      exit!
    end

    game.on_event(:mine_detonated) do
      mines.each { |e| e.stop }

      grenade.pitch = 1.5
      grenade.play
      sleep grenade.duration
      exit!
    end

    game.on_event(:exit_located) do
      mines.each { |e| e.stop }

      win.play
      sleep win.duration
      exit!
    end

    always do
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
                      "Mines\n #{world.mine_positions.join("\n")}\n"+
                      "Exit\n #{world.exit_position}")
      end
    end
  end

  scenes << :main
end


=begin
Ray.game "Blind" do
  register { add_hook :quit, method(:exit!) }

  scene :main do
    self.frames_per_second = 10

    s = sound("#{File.dirname(__FILE__)}/../data/beep.wav")

    @game = Blind::World.new(ARGV[0] ? ARGV[0].to_i : 10)

    @horn = sound("#{File.dirname(__FILE__)}/../data/horn.wav")
    @horn.play
    @horn.looping = true
    @horn.volume = 0

    @phone = sound("#{File.dirname(__FILE__)}/../data/telephone.wav")
    @phone.looping = true
    @phone.play
    @phone.position = [@game.exit_position.x, @game.exit_position.y, 0]

    step = 0.2

    @mines = @game.mine_positions.map do |pos| 
      s          = sound("#{File.dirname(__FILE__)}/../data/beep.wav")
      s.pos      = [pos.x, pos.y, 1]
      s.looping  = true
      s.pitch    = step + rand(0.1)
      step += 0.1

      s.play

      s
    end

    @game.on_event(:out_of_bounds) do
      @horn.stop
      @mines.each { |m| m.stop }
      @phone.stop

      blast = sound("#{File.dirname(__FILE__)}/../data/grenade.wav")
      blast.play

      @text = "You fell off the world! YOU LOSE!"
    end

    @game.on_event(:mine_collision) do
      @horn.stop
      @mines.each { |m| m.stop }
      @phone.stop
     
      blast = sound("#{File.dirname(__FILE__)}/../data/grenade.wav")
      blast.play
       
      @text = "You were blown up by a mine! YOU LOSE!"
    end

    @game.on_event(:exit_located) do
      @horn.stop
      @mines.each { |m| m.stop }
      @phone.stop

      win = sound("#{File.dirname(__FILE__)}/../data/win.wav")
      win.play

      @text = "You found the exit! GOOD JOB BUDDY!"
    end

    render do |win|
      if @text
        win.draw(text(@text, :size => 20))
      else
        if $DEBUG
          win.draw text("Player position #{@game.player_position}\n"+
                        "risk of escape #{@game.escape_risk(20)}\n"+
                        "mine positions\n#{@game.mine_positions.join("\n")}\n"+
                        "exit #{@game.exit_position}", :size => 20)
        else
          win.draw text("Find the phone.\nAvoid the beeping mines and the sirens.\nUse WASD to move",
                        :size => 20)
        end
      end
    end

    always do
      @horn.volume = @game.escape_risk(20) * 100

      @game.move_player(0,-0.2) if holding?(:w) 
      @game.move_player(0,0.2)  if holding?(:s)
      @game.move_player(-0.2,0) if holding?(:a)
      @game.move_player(0.2,0)  if holding?(:d)

      Ray::Audio.pos = [@game.player_position.x, @game.player_position.y, 0]
    end
  end

  scenes << :main
end
=end
