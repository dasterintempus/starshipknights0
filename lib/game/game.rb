require 'gameship'
require 'gamestarmap'

include Gosu
module StarshipKnights

  class Game
    
    attr_reader :playeractiveship, :lastbattlestatus
    attr_accessor :difficulty
    def initialize
      @playeractiveship = nil
      @lastbattlestatus = 0
    end
    
    def selectship(ship)
      @playeractiveship = GameShip.new(ship)
    end
    
    def spawnplayership(battlestage, x, y, angle, opts=nil)
      return @playeractiveship.spawn(battlestage, x, y, angle, opts)
    end
    
    def losebattle
      @lastbattlestatus = -1
    end
    
    def winbattle
      @lastbattlestatus = 1
    end
  end
  
end