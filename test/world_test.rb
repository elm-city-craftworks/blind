require_relative "helper"
require_relative "../lib/blind/world"
require_relative "../lib/blind/point"

describe Blind::World do

  let(:world) { Blind::World.new(5) }
  let(:minefield_range) { Blind::World::MINE_FIELD_RANGE }

  it "must have mine positions" do
    world.mine_positions.count.must_equal(5)

    world.mine_positions.each do |pos|
      minefield_range.must_include(pos.x)
      minefield_range.must_include(pos.y) 
    end
  end

  it "must have an exit position in the minefield" do
    minefield_range.must_include(world.exit_position.x)
    minefield_range.must_include(world.exit_position.y)
  end

  it "must be able to determine the current position" do
    world.current_position.must_equal(Blind::Point.new(0,0))
    
    world.move_to(100,20)
    world.current_position.must_equal(Blind::Point.new(100,20))
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
      assert_region :outer_rim, point
    end
  end

  def assert_region(region, location)
    region.must_equal world.move_to(*location)
                      "expected #{location} to be in #{region}"
  end
end
