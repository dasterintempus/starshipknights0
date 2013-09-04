require 'gameship'
require 'gamestarmap'

include Gosu
module StarshipKnights

  class Game
    
    attr_reader :playeractiveship, :lastbattlestatus
    attr_accessor :difficulty, :score, :currentlevel, :tempscore
    def initialize
      @playeractiveship = nil
      @lastbattlestatus = 0
      @score = 0
      @tempscore = 0
      @currentlevel = 1
    end
    
    def selectship(ship)
      @playeractiveship = GameShip.new(ship)
    end
    
    def spawnplayership(battlestage, x, y, angle, opts=nil)
      return @playeractiveship.spawn(battlestage, x, y, angle, opts)
    end
    
    def losebattle
      @lastbattlestatus = -1
      @tempscore = 0
    end
    
    def winbattle
      @lastbattlestatus = 1
      @currentlevel += 1
      @score += @tempscore
      @tempscore = 0
    end
    
    def resetbattle
      @lastbattlestatus = 0
    end
  end
  
end