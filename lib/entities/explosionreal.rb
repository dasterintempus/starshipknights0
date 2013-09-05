require 'explosion'

module StarshipKnights
  module Entities
    class ExplosionReal < StarshipKnights::EntityTypes::Explosion
    
      def configure(opts)
        opts["imagename"] ||= "explosion"
        opts["lifetimer"] ||= 0.1
        super(opts)
      end
      
      def to_s
        return "ExplosionReal " + super
      end
      
    end
  end
end

        