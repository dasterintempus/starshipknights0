require 'explosion'

module StarshipKnights
  module Entities
    class ExplosionReal < StarshipKnights::EntityTypes::Explosion
    
      def configure(opts)
        if @teamid == 0 then
          opts["imagename"] ||= "explosionred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "explosionblue"
        end
        opts["lifetimer"] ||= 0.1
        super(opts)
      end
      
      def to_s
        return "ExplosionReal " + super
      end
      
    end
  end
end

        