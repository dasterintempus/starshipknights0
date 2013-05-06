require 'gameship'
require 'gamestarmap'

include Gosu
module StarshipKnights

  class Game
    
    attr_reader :playeractiveship, :starmap
    attr_accessor :playerstarcoords
    def initialize
      @playeractiveship = GameShip.new("djinn")
      @starmap = GameStarMap.new(35, 20, 15)
      @playerstarcoords = @starmap.stars.keys.sample
    end
    
    def spawnplayership(battlestage, x, y, angle, opts=nil)
      return @playeractiveship.spawn(battlestage, x, y, angle, opts)
    end
  end
  
end