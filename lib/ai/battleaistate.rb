require 'battleaipattern'
require 'allaipatterns'

include Gosu
module StarshipKnights
  class BattleAIState
    def initialize(parent)
      @parent = parent
      @patterns = []
    end
    
    def add_pattern(pattern, *args)
      @patterns << AIPatterns.all[pattern].new(self, *args)
    end
    
    def add_input(cmd, mode="")
      @parent.add_input(cmd, mode)
    end
    
    def think(dt)
      @patterns.each do |p|
        p.think(dt)
      end
    end
    
    def on_enter
      @patterns.each do |p|
        p.setup
      end
    end
    
    def on_leave
      @patterns.each do |p|
        p.teardown
      end
    end
    
    
    
  end
end