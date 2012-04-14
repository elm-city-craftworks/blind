require_relative "helper"
require_relative "../lib/blind/game"

require "ostruct"

describe Blind::Game do
  let(:world) { MiniTest::Mock.new }
  let(:game) { Blind::Game.new(world) }

  events = [:out_of_bounds, :mine_collision, :exit_located]

  events.each do |event_type|
    it "can trigger an #{event_type} event" do
      game = Blind::Game.new(world)

      world.expect(:move_player, event_type, [Numeric, Numeric])

      event_raised = false

      # register all events to show only one type gets triggered
      events.each { |e| game.on_event(e) { event_raised = true } }

      refute event_raised, "Did not expect #{event_type} event to be raised"

      game.move(1,0)

      assert event_raised, "Expected :out_of_bounds event to be raised"
    end
  end

  it "can complete a move without triggering any events" do
    game = Blind::Game.new(world)

    world.expect(:move_player, nil, [Numeric, Numeric])

    event_raised = false

    # register all events to show that none get triggered
    events.each { |e| game.on_event(e) { event_raised = true } }
    
    game.move(1,0)
    refute event_raised, "Did not expect any events to be raised"
  end
end
