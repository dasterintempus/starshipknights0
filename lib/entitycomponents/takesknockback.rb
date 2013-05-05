module StarshipKnights
  module Components
    module TakesKnockback
    
      def collide(other)
        #puts "Getting collision call"
        if other.teamid != @teamid then
          oci = other.collideinfo
          knockback(other, oci[:knockback]) if oci[:knockback]
        end
        super(other)
      end
      
      def to_s
        return "TakesKnockback " + super
      end
      
      def knockback(other, power)
        dx = @x - other.x
        dy = @y - other.y
        angle_between = Util.deg(Math.atan2(dy, dx))
        dxvel, dyvel = Util.vector(angle_between)
        accel(dxvel*power, dyvel*power)
      end
      
    end
  end
end