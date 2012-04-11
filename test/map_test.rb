require_relative "helper"
require_relative "../lib/blind/map"

describe Blind::Map do
  it "must be able to store objects at a position" do
    map = Blind::Map.new
    map.place("player", 10, 25)

    pos = map.locate("player")
    [pos.x, pos.y].must_equal([10,25])
  end
  
  it "must be able to move objects" do
    map = Blind::Map.new
    map.place("player", 10, 25)
    map.move("player", 5, 50)
    pos = map.locate("player")
    [pos.x, pos.y].must_equal([15,75])    
  end
  
end
