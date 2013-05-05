require 'shield'

module StarshipKnights
  module Entities
    class PegasusShield < StarshipKnights::EntityTypes::Shield
    
      def configure(opts)
        opts["radius"] ||= 25.0
        if @teamid == 0 then
          opts["imagename"] ||= "shieldred"
        elsif @teamdi == 1 then
          opts["imagename"] ||= "shieldblue"
        end
        opts["absorbsound"] ||= "shieldhit"
        opts["absorbdrainfactor"] ||= 0.35
        opts["casterspecialdrain"] ||= 0.35
        super(opts)
      end
      
      def to_s
        return "PegasusShield " + super
      end
      
    end
  end
end