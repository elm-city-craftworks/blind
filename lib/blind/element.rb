require "ray"

module Blind
  class Element
    def initialize(params)
      @name, @size, @position = params.values_at(:name, :size, :position)
    end

    def to_rect
      [position[0] - size/2.0, position[1] - size/2.0, size, size].to_rect
    end

    def collide?(other_element)
      to_rect.collide?(other_element.to_rect)
    end
    
    attr_reader   :name, :size
    attr_accessor :position
  end
end
