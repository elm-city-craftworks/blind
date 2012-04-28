require_relative "worlds"

module Blind
  module Games
    def self.original(mine_count)
      [Blind::Level.new(
         Blind::Worlds.original(mine_count),
         "Find the phone, avoid the beeping mines and sirens\n"+
         "Use the WASD keys to move"
      )]
    end

    def self.cramped
      [Blind::Level.new(
        Blind::Worlds.cramped(30),
          "The world just got a whole lot smaller.\n"+
          "Even though the phone might be closer by,\n"+
          "so are all the mines!")]
    end

    def self.standard
      [Blind::Level.new(
        Blind::Worlds.trivial(0),
        "This is just a warmup, find the phone!\n"+
        "But beware not to stray too far, if you hear\n"+
        "sirens, head back where you came from"),
       Blind::Level.new(
         Blind::Worlds.original(5),
         "Now you're ready to ramp things up a bit\n"+
         "Avoid the beeping mines, they'll blast you\n"+
         "if you get too close to them!"),
       Blind::Level.new(
         Blind::Worlds.original(30),
         "Good job buddy! Now you're ready for the real deal.\n"+
         "There are a LOT more mines now, so watch out!"),
       Blind::Level.new(
         Blind::Worlds.cramped(30),
         "The world just got a whole lot smaller.\n"+
         "Even though the phone might be closer by,\n"+
         "so are all the mines!")]

    end
  end
end
