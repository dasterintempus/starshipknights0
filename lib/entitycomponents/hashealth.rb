module StarshipKnights
  module Components
    module HasHealth
      attr_reader :health, :maxhealth
      attr_accessor :hitsound, :diesound
      
      def configure(opts)
        @maxhealth = opts["maxhealth"]
        @hitsound = opts["hitsound"]
        @diesound = opts["diesound"]
        super(opts)
      end
      
      def setup
        @health = @maxhealth
        super
      end
      
      def hurt(damage)
        return true unless damage > 0.0
        @health -= damage
        if @health <= 0 then
          die
          return false
        end
        if @hitsound then
          play_sound(@hitsound, @x, @y)
        end
        return true
      end
      
      def heal(life)
        return unless life > 0.0
        @health += life
        @health = @maxhealth if @health > @maxhealth
      end
      
      def die
        if @diesound then
          play_sound(@diesound, @x, @y)
        end
        @stage.kill_by_id(@id)
      end
      
      def to_s
        return "HasHealth " + super
      end
    end
  end
end
