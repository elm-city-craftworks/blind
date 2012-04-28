module Blind
  class Level
    def initialize(world, message)
      @world, @message = world, message
    end

    attr_reader :world, :message
  end
end
