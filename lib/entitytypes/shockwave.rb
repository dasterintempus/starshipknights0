require 'weapon'
require 'followscaster'

module StarshipKnights
  module EntityTypes
    class Shockwave < StarshipKnights::BattleEntity
      include StarshipKnights::Components::FollowsCaster
      include StarshipKnights::Components::Weapon
      
      def setup
        @damage = @hits
        super
      end
      
      def physics(dt, inputs)
        @damage = @hits
        super(dt, inputs)
      end
      
      def collideinfo
        return super.merge({:shockwave => true})
      end
      
    end
  end
end