require_relative "helper"
require_relative "../lib/blind/game"

describe Blind::Game do
  let(:world) { MiniTest::Mock.new }

  it "must be able to trigger an event when the abyss is reached" do
    game = Blind::Game.new(world)

    world.expect(:current_position, [0,0])
    world.expect(:move_to, :abyss, [Numeric, Numeric])


    dead = false
    game.on_event(:abyss_reached) { dead = true }

    refute dead, "should not be dead before the abyss is reached"

    game.move(500,500)

    assert dead, "should be dead once the abyss is reached"
  end
end
