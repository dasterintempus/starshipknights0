require 'accelmover'
require 'turner'

module StarshipKnights
  module Components
    module Thruster
      include StarshipKnights::Components::AccelMover
      include StarshipKnights::Components::Turner
      
      attr_reader :thrustspeed
      
      def configure(opts)
        @thrustspeed = opts["thrustspeed"]

        super(opts)
      end
      
      def physics(dt, inputs)
        inputs.each do |input|
          case input.cmd
            when "right"
              turn_right(dt)
            when "left"
              turn_left(dt)
            when "thrust"
              move(dt, @thrustspeed, nil, nil, nil)
            when "rthrust"
              move(dt, nil, nil, nil, @thrustspeed * 2.0/3.0)
          end
        end
        
        super(dt, inputs)
      end
      
    end
  end
end