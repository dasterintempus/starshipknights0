module StarshipKnights
  module Components
    module Turner
      attr_accessor :turnspeed

      def configure(opts)
        @turnspeed = opts["turnspeed"]

        super(opts)
      end
    
      def rotate(da)
        @angle += da
        @angle += 360.0 if @angle < 0
        @angle -= 360.0 if @angle > 360.0
      end
      
      def turn_right(dt)
        rotate(@turnspeed * dt) if @turnspeed
      end
      
      def turn_left(dt)
        rotate(-@turnspeed * dt) if @turnspeed
      end
      
      def to_s
        return "Turner " + super
      end
    end
  end
end