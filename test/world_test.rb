require_relative "helper"
require_relative "../lib/blind/world"
require_relative "../lib/blind/point"
require_relative "../config/worlds"

# FIXME: SPLIT OUT GENERAL TESTS FROM SCENARIO INDEPENDENT TESTS.

describe Blind::World do
  let(:world) do
    Blind::Worlds.original(5)
  end

  let(:minefield_range) do
    (20...100)
  end

  it "must have mine positions" do
    mine_positions = world.positions.all(:mine)
    
    mine_positions.count.must_equal(5)

    mine_positions.each do |pos|
      distance = world.center_point.distance(pos)
      minefield_range.must_include(distance) 
    end
  end

  it "must be able to look up regions by position" do
    world.region_at(Blind::Point.new(0,0)).must_equal(:safe_zone)
    world.region_at(Blind::Point.new(20,0)).must_equal(:mine_field)
    world.region_at(Blind::Point.new(100,0)).must_equal(:danger_zone)
    world.region_at(Blind::Point.new(120,0)).must_equal(:deep_space)
  end

  it "must have an exit position in the minefield" do
    exit_position = world.positions.first(:exit)

    distance = world.center_point.distance(exit_position)
    minefield_range.must_include(distance)
  end

  it "must be able to determine the current position" do
    world.reference_point.must_equal(Blind::Point.new(0,0))
    
    world.move_to(100,20)
    world.reference_point.must_equal(Blind::Point.new(100,20))
  end

  it "must locate points in the safe zone" do
    [[0,0], [19,0], [0,19.999]].each do |point|
      assert_region :safe_zone, point
    end
  end

  it "must locate points in the mine field" do
    [[20,0],[0,99]].each do |point|
      assert_region :mine_field, point
    end
  end

  it "must locate points in the danger zone" do
    [[0,100],[60,80]].each do |point|
      assert_region :danger_zone, point
    end
  end

  it "must locate points in the outer rim" do
    [[0,120], [120,0], [75, 150]].each do |point|
      assert_region :deep_space, point
    end
  end

  def assert_region(region, location)
    region.must_equal world.move_to(*location)
                      "expected #{location} to be in #{region}"
  end
end
