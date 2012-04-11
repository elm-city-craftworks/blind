require_relative "helper"
require_relative "../lib/blind/map"

describe Blind::Map do
  it "must be able to store objects at a position" do
    map = new_map
    map.place("player", 10, 25)

    pos = map.locate("player")
    [pos.x, pos.y].must_equal([10,25])
  end
  
  it "must be able to move objects" do
    map = new_map
    map.place("player", 10, 25)
    map.move("player", 5, 50)
    pos = map.locate("player")
    [pos.x, pos.y].must_equal([15,75])    
  end

  it "must be able to detect out of bounds objects" do
    map = new_map
    map.place("player1", 10, 25)
    map.must_be(:within_bounds?, "player1")
  end

  private

  def new_map(width=100, height=100)
    Blind::Map.new(width, height)
  end
  
end
