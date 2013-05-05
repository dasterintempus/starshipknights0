require 'hasvelocity'

module StarshipKnights
  module Components
    module VelMover
      include StarshipKnights::Components::HasVelocity
    
      attr_reader :maxspeed
      
      def configure(opts)
        @maxspeed = opts["maxspeed"]
        super(opts)
      end
    
      def move(dt, forward, right, left, reverse)
        txvel = 0
        tyvel = 0
        
        if forward then
          dx, dy = Util.vector(@angle)
          txvel += dx * forward
          tyvel += dy * forward
        end
        
        if reverse then
          dx, dy = Util.vector(@angle)
          txvel -= dx * reverse
          tyvel -= dy * reverse
        end
        
        if right then
          dx, dy = Util.vector(@angle + 90.0)
          txvel += dx * right
          tyvel += dy * right
        end
        
        if left then
          dx, dy = Util.vector(@angle - 90.0)
          txvel += dx * left
          tyvel += dy * left
        end
        
        if @maxspeed != nil then
          magvel = (txvel**2.0 + tyvel**2.0)**0.5
          max_magvel = Util.clamp(magvel, 0.0, @maxspeed)
          if magvel != 0.0 then
            txvel = (txvel/magvel) * max_magvel
            tyvel = (tyvel/magvel) * max_magvel
          end
        end
        
        @xvel += txvel
        @yvel += tyvel
      end
      
      def clear_vel
        @xvel = 0.0
        @yvel = 0.0
      end
      
      def to_s
        return "VelMover " + super
      end
      
    end
  end
end
