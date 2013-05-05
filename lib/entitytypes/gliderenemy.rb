require 'glider'
require 'enemy'

module StarshipKnights
  module EntityTypes
    class GliderEnemy < Enemy
      include StarshipKnights::Components::Glider
      
      def to_s
        return "GliderEnemy " + super
      end
      
    end
  end
end