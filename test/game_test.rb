require_relative "helper"
require_relative "../lib/blind/game"
require_relative "../lib/blind/world"
require_relative "../config/worlds"

describe Blind::Game do
  let(:world) do
    file = "#{File.dirname(__FILE__)}/fixtures/world.dump" 
    Marshal.load(File.binread(file))
  end

  let(:game)  { Blind::Game.new(world) }

  it "must trigger an event when deep space is reached" do
    dead = false

    game.on_event(:enter_region, :deep_space) { dead = true }

    refute dead, "should not be dead before the outer rim is reached"

    game.move(500,500)

    assert dead, "should be dead once the outer rim is reached"
  end

  it "must trigger an event when the danger zone is reached" do
    alert = false

    game.on_event(:enter_region, :danger_zone) { alert = true }
    game.on_event(:leave_region, :danger_zone) { alert = false }

    refute alert, "should not enable alert before danger zone is reached"

    game.move(100,0)
    assert alert, "should endable alert once danger zone is reached"

    game.move(-1, -1)
    refute alert, "should disable alert once danger zone is exited"
  end

  it "must trigger an event when a mine is detonated" do
    detonated = false

    game.on_event(:mine_detonated) { detonated = true }

    mine = world.positions.first(:mine)

    game.move(mine.x - Blind::Game::MINE_DETONATION_RANGE, mine.y)

    refute detonated, "should not be detonated before player is in the mine's range"

    game.move(1, 0)

    assert detonated, "should detonate when player is in the mine's range"
  end

  it "must trigger an event when the exit is located" do
    exit_located = false
    
    game.on_event(:exit_located) { exit_located = true }

    exit_pos = world.positions.first(:exit)

    game.move(exit_pos.x, exit_pos.y + Blind::Game::EXIT_ACTIVATION_RANGE)

    refute exit_located, "should not detect the exit when not yet in range"

    game.move(0,-1)

    assert exit_located, "should detect the exit when in range"
  end
end
