require 'velmover'
#require 'slider'
require 'turner'

module StarshipKnights
  module Components
    module Glider
      include StarshipKnights::Components::VelMover
      #include StarshipKnights::Components::Slider
      include StarshipKnights::Components::Turner
      
      attr_reader :forwardspeed, :reversespeed
      
      def configure(opts)        
        @forwardspeed = opts["forwardspeed"]
        @reversespeed = opts["reversespeed"]
        
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
              move(dt, @forwardspeed, nil, nil, nil)
            when "rthrust"
              move(dt, nil, nil, nil, @reversespeed)
          end
        end
        
        super(dt, inputs)
      end
      
      def to_s
        return "Glider " + super
      end
      
    end
  end
end