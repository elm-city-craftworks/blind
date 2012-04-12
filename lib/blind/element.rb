module Blind
  class Element
    def initialize(params)
      @name, @width, @length = params.values_at(:name, :width, :length)
    end
    
    attr_reader :name, :width, :length
  end
end
