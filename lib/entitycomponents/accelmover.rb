require 'hasvelocity'

module StarshipKnights
  module Components
    module AccelMover
      include StarshipKnights::Components::HasVelocity
      
      attr_reader :maxspeed
      
      def configure(opts)
        @maxspeed = opts["maxspeed"]
        super(opts)
      end
      
      def physics(dt, inputs)
        if @maxspeed != nil then
          magvel = (@xvel**2.0 + @yvel**2.0)**0.5
          max_magvel = Util.clamp(magvel, 0.0, @maxspeed)
          if magvel != 0.0 then
            @xvel = (@xvel/magvel) * max_magvel
            @yvel = (@yvel/magvel) * max_magvel
          end
        end
      
        super(dt, inputs)
      end
      
      def move(dt, forward, right, left, reverse)
        if forward then
          dx, dy = Util.vector(@angle)
          accel(dx*forward*dt, dy*forward*dt)
        end
        
        if reverse then
          dx, dy = Util.vector(@angle)
          accel(-dx*reverse*dt, -dy*reverse*dt)
        end
        
        if right then
          dx, dy = Util.vector(@angle + 90.0)
          accel(dx*right*dt, dy*right*dt)
        end
        
        if left then
          dx, dy = Util.vector(@angle - 90.0)
          accel(dx*left*dt, dy*left*dt)
        end
      end
      
      def accel(dx, dy)
        @xvel += dx
        @yvel += dy
      end
      
      def to_s
        return "AccelMover " + super
      end
    end
  end
end
