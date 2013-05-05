module StarshipKnights
  module Components
    module Slider
      
      attr_reader :slidespeed, :slidespecialdrainrate
      attr_accessor :sliding
      
      def configure(opts)
        @slidespeed = opts["slidespeed"]
        @slidespecialdrainrate = opts["slidespecialdrainrate"]
        super(opts)
      end
      
      def setup
        @sliding = false
        super
      end
      
      def physics(dt, inputs)
        if @sliding then
          #$logger.debug { "seeing @sliding true in Slider" }
          pass_inputs = []
          slide_drain = false
          inputs.each do |input|
            case input.cmd
              when "left"
                #$logger.debug { "sliding left" }
                move(dt, nil, nil, @slidespeed, nil)
                slide_drain = true
              when "right"
                #$logger.debug { "sliding right" }
                move(dt, nil, @slidespeed, nil, nil)
                slide_drain = true
              else
                #$logger.debug { "passing input: #{input}" }
                pass_inputs << input
            end
          end
          if slide_drain and @slidespecialdrainrate then
            drain_special(dt, @slidespecialdrainrate)
          end
          super(dt, pass_inputs)
        else
          super(dt, inputs)
        end
      end
    
      def to_s
        return "Slider " + super
      end
    end
  end
end