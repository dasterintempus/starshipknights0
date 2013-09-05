require 'shield'

module StarshipKnights
  module Entities
    class CentaurShield < StarshipKnights::EntityTypes::Shield
    
      def configure(opts)
        opts["radius"] ||= 25.0
        opts["imagename"] ||= "shield"
        opts["absorbsound"] ||= "shieldhit"
        opts["absorbdrainfactor"] ||= 0.35
        opts["casterspecialdrain"] ||= 0.35
        super(opts)
      end
      
      def to_s
        return "CentaurShield " + super
      end
      
    end
  end
end