require "ray"

class MainScene < Ray::Scene
  scene_name :main

  def setup
    @sound = sound("#{File.dirname(__FILE__)}/../../data/beep.wav")
  end

  def register
    always do
      @sound.play
      sleep @sound.duration
    end
  end

  def render(win)
   
  end
end

class Game < Ray::Game
  def initialize
    super "Awesome Game"

    MainScene.bind(self)

    scenes << :main
  end
end

Game.new.run
