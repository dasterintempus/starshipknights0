include Gosu
module StarshipKnights
  module AIPatterns
    module ZigZag
      def configure(opts)
        @zigtimer = opts["zigtimer"] || 1.5
        @zigdirections = ["right", "left"]
        
        super
      end
    
      def setup
        @zigtime = @zigtimer
        @zigdirindex = @zigdirections.count - 1
        add_input("special", "+")
        super
      end
      
      def think(dt)
        @zigtime -= dt if @zigtime > 0.0
        if @zigtime <= 0.0 then
          @zigtime = @zigtimer
          add_input(@zigdirections[@zigdirindex], "-")
          @zigdirindex += 1
          @zigdirindex = @zigdirindex % @zigdirections.count
          add_input(@zigdirections[@zigdirindex], "+")
        end
        
        super
      end
      
    end
    
  end
 
end