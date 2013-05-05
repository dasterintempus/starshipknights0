include Gosu
module StarshipKnights
  module AIPatterns
    module ForwardBack
      def configure(opts)
        @fbtimer = opts["fbtimer"] || 1.5
        @fbdirections = ["thrust", "rthrust"]
        super
      end
    
      def setup
        @fbtime = @fbtimer
        @fbdirindex = @fbdirections.count - 1
        super
      end
      
      def think(dt)
        @fbtime -= dt if @fbtime > 0.0
        if @fbtime <= 0.0 then
          @fbtime = @fbtimer
          add_input(@fbdirections[@fbdirindex], "-")
          @fbdirindex += 1
          @fbdirindex = @fbdirindex % @fbdirections.count
          add_input(@fbdirections[@fbdirindex], "+")
        end
        
        super
      end
      
    end
    
  end
 
end