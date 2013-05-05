module StarshipKnights
  module Components
    module TakesDamageCollisions
    
      def collide(other)
        if other.teamid != @teamid then
          #d = Util.distance(other.x, other.y, @x, @y)
          #puts "Distance: #{d}"
          oci = other.collideinfo
          hurt(oci[:damage]) if oci[:damage]
        end
        super(other)
      end
      
      def to_s
        return "TakesDamageCollisions " + super
      end
      
    end
  end
end