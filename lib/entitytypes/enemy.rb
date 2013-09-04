require 'aidriver'
require 'hasweapons'
require 'hashealth'
require 'takesdamagecollisions'

module StarshipKnights
  module EntityTypes
    class Enemy < StarshipKnights::BattleEntity
      include StarshipKnights::Components::AIDriver
      include StarshipKnights::Components::HasHealth
      include StarshipKnights::Components::HasWeapons
      include StarshipKnights::Components::TakesDamageCollisions
    
      attr_reader :damage, :scorevalue
      
      def configure(opts)
        opts["radius"] ||= 10.0
        opts["hitsound"] ||= "hit"
        opts["diesound"] ||= "shipdie"
        @damage = opts["damage"]
        @scorevalue = opts["scorevalue"]

        super(opts)
      end
    
      def collideinfo
        return super.merge({:enemy => true, :damage => @damage})
      end
      
      def collide(other)
        if other.teamid != @teamid then
          #d = Util.distance(other.x, other.y, @x, @y)
          #puts "Distance: #{d}"
          oci = other.collideinfo
          die if other.is_ship
          die if oci[:shield]
        end
        super
      end
      
      def die
        $game.tempscore += @scorevalue
        super
      end
      
      def to_s
        return "Enemy " + super
      end
      
    end
  end
end