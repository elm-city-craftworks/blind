require_relative "helper"
require_relative "../lib/blind/element"

describe Blind::Element do
  it "must have a name, a size, and a position" do
    element = Blind::Element.new(:name     => "player", 
                                 :position => [10,10],
                                 :size     => 3 )

    element.name.must_equal("player")
    element.size.must_equal(3)
    element.position.must_equal([10,10])
  end

  it "must be able to convert into a rectangle" do
    element = Blind::Element.new(:name     => "player", 
                                 :size     => 5,
                                 :position => [10,10])


    rect = element.to_rect
    rect.center.must_equal([10,10].to_vector2)
  end

  it "must be able to determine whether it collides with another element" do
    player = Blind::Element.new(:name     => "player",
                                :size     => 5,
                                :position => [10,10])

    far_away_mine = Blind::Element.new(:name => "far away mine",
                                       :size => 10,
                                       :position => [50,50])

    nearby_mine = Blind::Element.new(:name     => "nearby mine",
                                     :size     => 10,
                                     :position => [15, 15])

    refute player.collide?(far_away_mine), "Should not trigger far away mine"
    assert player.collide?(nearby_mine),   "Should trigger nearby mine"
  end
end
