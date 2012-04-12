module Blind
  class Element
    def initialize(params)
      @name, @width, @height = params.values_at(:name, :width, :height)
    end
    
    attr_reader :name, :width, :height
  end
end
