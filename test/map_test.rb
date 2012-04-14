require_relative "helper"

require_relative "../lib/blind/element"
require_relative "../lib/blind/map"

describe Blind::Map do
  it "must be able to store objects at a position" do
    map    = new_map
    player = new_element("player")

    map[player] = [10, 25]

    pos = map[player]
    [pos.x, pos.y].must_equal([10,25])
  end
  
  it "must be able to move objects" do
    map    = new_map
    player = new_element("player")

    map[player] = [10, 25]
    map.move(player, 5, 50)
    pos = map[player]
    [pos.x, pos.y].must_equal([15,75])    
  end

  it "must be able to detect out of bounds objects" do
    map = new_map

    inbounds_player  = new_element("player 1")
    outbounds_player = new_element("player 2")

    map[inbounds_player] = [10, 25]
    map.must_be(:within_bounds?, inbounds_player)

    [[4,50],[50,4],[50,96],[96,50]].each do |x,y|
      map[outbounds_player] = [x, y]
      map.wont_be(:within_bounds?, outbounds_player)
    end
  end

  it "must be able to detect minimum distance from boundaries" do
    map = new_map

    player = new_element("player 1")
    
    # starting at (10,25)
    map[player] = [10, 25]

    map.nearest_boundary(player).must_equal(5)

    # now at (10, 7)
    map.move(player, 0, -18)
    map.nearest_boundary(player).must_equal(2)

    # now at (10, 91)
    map.move(player, 0, 84) 
    map.nearest_boundary(player).must_equal(4)

    # now at (92, 91)
    map.move(player, 82, 0)
    map.nearest_boundary(player).must_equal(3)
  end

  private

  def new_element(name, size=10)
    Blind::Element.new(:name => name, :size => size)
  end

  def new_map(width=100, height=100)
    Blind::Map.new(width, height)
  end
  
end
