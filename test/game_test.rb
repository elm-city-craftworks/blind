require_relative "helper"
require_relative "../lib/blind/game"

describe Blind::Game do
  it "must control player movement" do
    game = Blind::Game.new

    pos = game.player_position

    game.move_player(3,2)
    game.move_player(7,-5)

    game.player_position.must_equal(Ray::Vector2.new(pos.x + 10, pos.y - 3))
  end

  it "must kill the player when out of bounds" do
    game = Blind::Game.new
    dead = false

    game.on_event(:out_of_bounds) { dead = true }
    game.move_player(-5,0)

    dead.must_equal(true)
  end
end
