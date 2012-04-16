require_relative "helper"
require_relative "../lib/blind/point"

describe Blind::Point do
  it "must have x and y components" do
    point = Blind::Point.new(2,3)
    point.x.must_equal(2) 
    point.y.must_equal(3)
  end

  it "must compute distance between itself and another point" do
    point_a = Blind::Point.new(2,  3)
    point_b = Blind::Point.new(-1, 7)

    point_a.distance(point_b).must_equal(5)
    point_b.distance(point_a).must_equal(5)
  end

  it "must be considered equal to another point when distance=0" do
    point_a = Blind::Point.new(2, 3)
    point_b = Blind::Point.new(2, 3)
    point_c = Blind::Point.new(4, 5)

    point_a.must_equal(point_a)

    point_a.must_equal(point_b)
    point_b.must_equal(point_a)
    
    point_a.wont_equal(point_c)
    point_b.wont_equal(point_c)
  end

  it "must have a nice string representation" do
    point_a = Blind::Point.new(3,7)

    point_a.to_s.must_equal("(3, 7)")
  end
end
