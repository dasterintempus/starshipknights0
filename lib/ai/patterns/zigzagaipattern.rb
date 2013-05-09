require 'battleaipattern'

include Gosu
module StarshipKnights
  module AIPatterns
    class ZigZag < BattleAIPattern
      def initialize(parent, special=false, timer=nil, directions=nil)
        super(parent)
        @timer = timer || 1.5
        @special = special
        @directions = directions || ["left", "right"]
      end
    
      def setup
        @time = 0.0
        @dirindex = @directions.count - 1
        add_input("special", "+") if @special
        super
      end
      
      def think(dt)
        @time -= dt if @time > 0.0
        if @time <= 0.0 then
          @time = @timer
          add_input(@directions[@dirindex], "-")
          @dirindex += 1
          @dirindex = @dirindex % @directions.count
          add_input(@directions[@dirindex], "+")
        end
        
        super
      end
      
    end
    
  end
 
end