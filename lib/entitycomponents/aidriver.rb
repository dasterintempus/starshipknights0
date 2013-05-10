module StarshipKnights
  module Components
    module AIDriver
      def setup
        @destangle = nil
        super
      end
      
      def physics(dt, inputs)
        pass_inputs = []
        if @destangle then
          if dt * @turnspeed < _anglediff.abs then
            if _anglediff > 0 then
              turn_right(dt)
            elsif _anglediff < 0 then
              turn_left(dt)
            end
          else
            rotate(_anglediff)
          end
        end
        
        inputs.each do |input|
          case input.cmd
            when "right"
              pass_inputs << input unless @destangle
            when "left"
              pass_inputs << input unless @destangle
            else
              pass_inputs << input
          end
        end
        super(dt, pass_inputs)
      end
      
      def turn(angled)
        @destangle = @angle + angled
        @destangle = @destangle % 360.0
      end
      
      def turn_to(angle)
        @destangle = angle
        @destangle = @destangle % 360.0
      end
      
      def _anglediff
        diff = @destangle - @angle
        diff += 360.0 if diff <= -180.0
        diff -= 360.0 if diff > 180.0
        return diff
      end
      
      def to_s
        return "AIDriver " + super
      end
    end
  end
end