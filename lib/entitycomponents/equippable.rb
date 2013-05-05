module StarshipKnights
  module Components
    module Equippable
  
      attr_reader :equippedprimary, :equippedsecondary, :equippedspecial
      def equip(primary, secondary, special)
        @equippedprimary = primary.downcase
        @equippedsecondary = secondary.downcase
        @equippedspecial = special.downcase
        #$logger.debug {"Pri: #{@equip_primary}, Sec: #{@equip_secondary}, Spc: #{@equip_special}"}
      end
    
    end
  end
end