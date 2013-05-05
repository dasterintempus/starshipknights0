require 'haslifetime'

module StarshipKnights
  module EntityTypes
    class Explosion < StarshipKnights::BattleEntity
      include StarshipKnights::Components::HasLifetime
      def configure(opts)
        @damage = opts["damage"]
        super(opts)
      end
      
      def setup
        @angle = 0
        @max_radius = @radius
        @radius = 0.0
        super
      end
      
      def collideinfo
        return {:explosion => true, :damage => @damage, :knockback => @radius}
      end
      
      def collide(other)
        if other.teamid != teamid then
          oci = other.collideinfo
          unless oci[:weapon] then
            @damage -= 1.5
            @stage.kill_by_id(@id) if @damage <= 0.0
            return
          end
        end
        super
      end
      
      def physics(dt, inputs)
        #puts @lifetimer, @lifetime
        @radius = -((@lifetime - @lifetimer)/@lifetimer) * @max_radius
        super
      end
      
      def to_s
        return "Explosion " + super
      end
    end
  end
end