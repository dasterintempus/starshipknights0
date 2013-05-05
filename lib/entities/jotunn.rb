require 'ship'

module StarshipKnights
  module Entities
    class Jotunn < StarshipKnights::EntityTypes::Ship
      attr_reader :turretmode
      
      def configure(opts)
        if @teamid == 0 then
          opts["imagename"] ||= "jotunnred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "jotunnblue"
        end
        if @equippedprimary == "triangleshot" then
          opts["priweptypename"] ||= "triangleshot"
          #opts["weaponcdtimer"] ||= 0.45
        elsif @equippedprimary == "railcannon"
          opts["priweptypename"] ||= "railcannon"
          #opts["weaponcdtimer"] ||= 1.85
        end
        opts["secweptypename"] = "torpedo"
        #opts["altweaponcdtimer"] = 2.5
        opts["turnspeed"] = 150.0
        opts["thrustspeed"] ||= 130.0
        #opts["reverseaccelrate"] ||= 105.0
        opts["maxspeed"] ||= 175.0
        opts["maxhealth"] ||= 18.5
        opts["maxspecial"] ||= 7.5
        super(opts)
      end
      
      def setup
        @weaponcooldownmod = 1.0
        @turretmode = false
        super
      end
      
      def physics(dt, inputs)
        inputs.each do |input|
          case input.cmd
            when "special"
              if @curspecial >= 7.5 then
                @turretmode = true
                @xvel = 0
                @yvel = 0
                @weaponcooldownmod = 0.65
                play_sound("turretmode", @x, @y)
              end
          end
        end
        super(dt, inputs)
        if @turretmode then
          @xvel = 0
          @yvel = 0
          drain_special(dt, 1.5)
          if @curspecial <= 0 then
            @turretmode = false
            @weaponcooldownmod = 1.0
          end
        else
          recharge_special(dt)
        end
      end
      
      def to_s
        return "Jotunn " + super
      end
      
      def knockback(other, power)
        super unless @turretmode
      end
      
      def priwepcooldowntimer
        return super * @weaponcooldownmod
      end
      
      def secwepcooldowntimer
        return super * @weaponcooldownmod
      end
    end
  end
end