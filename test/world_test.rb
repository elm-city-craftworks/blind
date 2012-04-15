require_relative "helper"
require_relative "../lib/blind/world"

describe Blind::World do

  let(:world) { Blind::World.new }

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
    world.move_to(*location)
   
    region.must_equal world.current_region,
                      "expected #{location} to be in #{region}"
  end
end
