require_relative "helper"
require_relative "../lib/blind/element"

describe Blind::Element do
  it "must have a name, a width, and a length" do
    element = Blind::Element.new(:name => "player", :width => 1, :height => 3)

    element.name.must_equal("player")
    element.width.must_equal(1)
    element.height.must_equal(3)
  end
end
