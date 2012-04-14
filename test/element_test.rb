require_relative "helper"
require_relative "../lib/blind/element"

describe Blind::Element do
  it "must have a name and a size" do
    element = Blind::Element.new(:name => "player", :size => 3)

    element.name.must_equal("player")
    element.size.must_equal 3
  end

  it "must be able to convert into a rectangle" do
    element = Blind::Element.new(:name => "player", :size => 5)

    rect = element.to_rect(10,10)
    rect.center.must_equal([10,10].to_vector2)
  end
end
