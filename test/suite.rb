require "simplecov"
SimpleCov.start

require_relative "point_test"
require_relative "world_test"
require_relative "game_test"

if ENV['TEST_ALL']
  require_relative "acceptance_test"
end
