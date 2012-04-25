require_relative "helper"

require_relative "../lib/blind"
require_relative "../config/worlds"

describe "The full game" do
  it "should result in a loss on mine collision" do
    world = Blind::Worlds.original(1)
    game  = Blind::UI::GamePresenter.new(world)

    sim   = Blind::UI::Simulator.new(game)

    mine = world.positions.first(:mine)

    sim.move(mine.x, mine.y)

    sim.status.must_equal "You got blasted by a mine! YOU LOSE!"
  end

  it "should result in a loss on entering deep space" do
    world = Blind::Worlds.original(0)
    game  = Blind::UI::GamePresenter.new(world)

    sim   = Blind::UI::Simulator.new(game)

    sim.move(500, 500)
    
    sim.status.must_equal "You drifted off into deep space! YOU LOSE!"
  end

  it "should result in a win when the exit location is reached" do
    world = Blind::Worlds.original(0)
    game  = Blind::UI::GamePresenter.new(world)

    sim   = Blind::UI::Simulator.new(game)

    destination = world.positions.first(:exit)

    sim.move(destination.x, destination.y)

    sim.status.must_equal "You found the exit! YOU WIN!"
  end
end
