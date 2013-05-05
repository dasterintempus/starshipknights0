require 'followscaster'

module StarshipKnights
  module EntityTypes
    class Shield < StarshipKnights::BattleEntity
      include StarshipKnights::Components::FollowsCaster
    
      attr_reader :absorbsound, :absorbdrainfactor
      
      def configure(opts)
        @absorbsound = opts["absorbsound"]
        @absorbdrainfactor = opts["absorbdrainfactor"]
        super(opts)
      end
      
      def collide(other)
        if other.teamid != teamid then
          oci = other.collideinfo
          if oci[:damage] and not oci[:shieldpen] then
            absorb(oci[:damage])
            return
          end
        end
        super
      end
      
      def collideinfo
        return super.merge({:shield => true})
      end
      
      def absorb(damage)
        caster = get_caster
        return unless caster
        caster.disrupt_special(damage * @absorbdrainfactor) if @absorbdrainfactor
        play_sound(@absorbsound, @x, @y)
      end
      
      def to_s
        return "Shield " + super
      end
      
    end
  end
end