require_relative "helper"
require_relative "../lib/blind/game"

describe Blind::Game do
  let(:world) { MiniTest::Mock.new }

  it "must be able to trigger an event when the abyss is reached" do
    game = Blind::Game.new(world)
    flunk
  end
end
