require 'turner'

module StarshipKnights
  module Components
    module HasVelocity
      include StarshipKnights::Components::Turner
      attr_reader :xvel, :yvel, :anglevel
      
      def setup
        @xvel ||= 0.0
        @yvel ||= 0.0
        #@anglevel = 0.0
        super
      end
      
      def physics(dt, inputs)
        @x += @xvel * dt
        @y += @yvel * dt
        rotate(@anglevel * dt) if @anglevel
        
        super(dt, inputs)
      end
      
      def to_s
        return "HasVelocity " + super
      end
      
    end
  end
end