require 'velmover'
require 'weapon'

module StarshipKnights
  module EntityTypes
    class Shot < StarshipKnights::BattleEntity
      include StarshipKnights::Components::VelMover
      include StarshipKnights::Components::Weapon
      
      attr_reader :inheritance, :speed, :shieldpen, :inheritxvel, :inherityvel
      
      def configure(opts)
        @inheritance = opts["inheritance"]
        @speed = opts["speed"]
        @shieldpen = opts["shieldpen"]
        
        super(opts)
      end
      
      def setup
        parent = @stage.get_by_id(@shipid)
        @inheritxvel = @inheritance * parent.xvel
        @inherityvel = @inheritance * parent.yvel
        
        super
      end
      
      def collide(other)
        if other.teamid != @teamid then
          if has_hits then
            oci = other.collideinfo
            if oci[:shield] then
              if not @shieldpen then
                expire
                return
              end
            end
            if not oci[:weapon] and not oci[:portal] then
              hit(other)
              return
            end
          end
        end
        super
      end
      
      def physics(dt, inputs)
        clear_vel
        
        move(dt, @speed, nil, nil, nil)
        @xvel += @inheritxvel
        @yvel += @inherityvel
        super(dt, inputs)
      end
      
      def to_s
        return "Shot " + super
      end
    end
  end
end