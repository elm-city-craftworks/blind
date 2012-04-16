require_relative "helper"
require_relative "../lib/blind/game"
require_relative "../lib/blind/world"

describe Blind::Game do
  it "must trigger an event when the outer rim is reached" do
    game = Blind::Game.new(Blind::World.new(5))

    dead = false
    game.on_event(:enter_region, :outer_rim) { dead = true }

    refute dead, "should not be dead before the outer rim is reached"

    game.move(500,500)

    assert dead, "should be dead once the outer rim is reached"
  end

  it "must trigger an event when the danger zone is reached" do
    game = Blind::Game.new(Blind::World.new(5))

    alert = false
    game.on_event(:enter_region, :danger_zone)  { alert = true }
    game.on_event(:leave_region,  :danger_zone) { alert = false }

    refute alert, "should not trigger alert before danger zone is reached"

    game.move(100,0)
    assert alert, "should trigger alert once danger zone is reached"

    game.move(-1, -1)
    refute alert, "should not trigger once danger zone is exited"
  end

  it "must trigger an event when a mine is detonated" do

  end
end
