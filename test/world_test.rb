require_relative "helper"
require_relative "../lib/blind/point"
require_relative "../lib/blind/world"

describe Blind::World do

  let(:world) { Blind::World.new }

  it "must locate points in the safe zone" do
    world.region(pt(0,0)).must_equal(:safe_zone)
    world.region(pt(0,19)).must_equal(:safe_zone)
    world.region(pt(19,0)).must_equal(:safe_zone)
  end

  it "must locate points in the mine field" do
    world.region(pt(20,0)).must_equal(:mine_field)
    world.region(pt(0,99)).must_equal(:mine_field)
  end

  it "must locate points in the danger zone" do
    world.region(pt(0,100)).must_equal(:danger_zone)
    world.region(pt(60,80)).must_equal(:danger_zone)
  end

  it "must locate points in the outer rim" do
    world.region(pt(0,120)).must_equal(:outer_rim)
    world.region(pt(0,120)).must_equal(:outer_rim)
    world.region(pt(75,150)).must_equal(:outer_rim)
  end

  def pt(x,y)
    Blind::Point.new(x,y)
  end
end
