require 'thruster'
require 'enemy'
require 'takesknockback'

module StarshipKnights
  module EntityTypes
    class ThrusterEnemy < Enemy
      include StarshipKnights::Components::Thruster
      include StarshipKnights::Components::TakesKnockback
      
      def to_s
        return "ThrusterEnemy " + super
      end
      
    end
  end
end