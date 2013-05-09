include Gosu
module StarshipKnights
  class BattleAIPattern
    def initialize(parent)
      @parent = parent
    end
    
    def add_input(cmd, mode="")
      @parent.add_input(cmd, mode)
    end
    
    def setup
    end
    
    def teardown
    end
    
    def think(dt)
    end
    
  end
end