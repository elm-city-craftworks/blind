require_relative "helper"
require_relative "../lib/blind/map"

describe Blind::Map do
  it "must be able to store elements at a position" do
    map = Blind::Map.new
    map.add_object("player", 10, 25)

    pos = map.locate("player")
    [pos.x, pos.y].must_equal([10,25])
  end
end
