module StarshipKnights
  module Components
    module HasSpecialGauge
      attr_reader :maxspecial, :specialrechargerate
      attr_accessor :curspecial
      
      def configure(opts)
        @maxspecial = opts["maxspecial"]
        @specialrechargerate = opts["specialrechargerate"] || 3.5
        super(opts)
      end
      
      def setup
        @curspecial = @maxspecial
        super
      end
      
      def collide(other)
        #puts "Getting collision call"
        if other.teamid != teamid then
          #d = Util.distance(other.x, other.y, @x, @y)
          #puts "Distance: #{d}"
          oci = other.collideinfo
          if oci[:disrupt] then
            disrupt_special(oi[:disrupt])
          end
        end
        super(other)
      end
      
      def drain_special(dt, n)
        @curspecial -= dt * n
        clamp_special
      end
      
      def disrupt_special(n)
        @curspecial -= n
        clamp_special
      end
      
      def recharge_special(dt)
        @curspecial += dt/@specialrechargerate
        clamp_special
      end
      
      def clamp_special
        @curspecial = Util.clamp(@curspecial, 0.0, @maxspecial)
      end
      
      def to_s
        return "HasSpecialGauge " + super
      end
      
    end
  end
end