require 'shockwave'

module StarshipKnights
  module Entities
    class ThunderbirdShockwave < StarshipKnights::EntityTypes::Shockwave
    
      def configure(opts)
        opts["imagename"] ||= "thunderbirdshockwave"
        opts["radius"] ||= 23
        opts["lifetimer"] ||= 1.0
        opts["firesound"] ||= "shockwave"
        opts["hits"] ||= 7
        super(opts)
      end
      
      def physics(dt, inputs)
        caster = get_caster
        @angle = caster.angle if caster
        super(dt, inputs)
      end
      
      def to_s
        return "ThunderbirdShockwave " + super
      end
      
    end
  end
end