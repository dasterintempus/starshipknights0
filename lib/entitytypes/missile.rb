require 'thruster'
require 'weapon'

module StarshipKnights
  module EntityTypes
    class Missile < StarshipKnights::BattleEntity
      include StarshipKnights::Components::Thruster
      include StarshipKnights::Components::Weapon
      
      attr_reader :blastsize, :inheritance
      attr_accessor :blastsound
      
      def configure(opts)
        @blastsize = opts["blastsize"]
        @blastsound = opts["blastsound"]
        @inheritance = opts["inheritance"] || 1.0
        opts["totalhits"] ||= 1
        super(opts)
      end
      
      def setup
        if @inheritance then
          parent = @stage.get_by_id(@shipid)
          @inheritxvel = @inheritance * parent.xvel
          @inherityvel = @inheritance * parent.yvel
          #puts @inheritxvel, @inherityvel
          #puts @xvel, @yvel
          @xvel ||= @inheritxvel
          @yvel ||= @inherityvel
          #puts @xvel, @yvel
        end
        super
      end
      
      def collideinfo
        return super.merge({:missile => true})
      end
      
      def collide(other)
        if other.teamid != @teamid then
          if has_hits then
            oci = other.collideinfo
            if oci[:missile] or not oci[:weapon] then
              if not oci[:portal] then
                hit(other)
                return
              end
            end
          end
        end
        super(other)
      end
      
      def physics(dt, inputs)
        found_thrust = false
        inputs.each do |input|
          case input.cmd
            when "thrust"
              found_thrust = true
          end
        end
        
        inputs << InputEvent.new("thrust", "") unless found_thrust
        
        super(dt, inputs)
      end
      
      def expire
        detonate
        super
      end
      
      def detonate
        opts = {}
        opts["radius"] = @blastsize
        opts["damage"] = @damage
        @stage.spawn("explosion", opts, @teamid, @shipid, @x, @y, 0.0)
        if @blastsound then
          play_sound(@blastsound, @x, @y)
        end
      end
      
      def to_s
        return "Missile " + super
      end
      
    end
  end
end