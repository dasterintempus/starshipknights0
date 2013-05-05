require 'ship'

module StarshipKnights
  module Entities
    class Pegasus < StarshipKnights::EntityTypes::Ship
      
      def configure(opts)
        if @teamid == 0 then
          opts["imagename"] ||= "pegasusred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "pegasusblue"
        end
        if @equippedprimary == "ringshot" then
          opts["priweptypename"] ||= "ringshot"
          #opts["weaponcdtimer"] ||= 0.7
        elsif @equippedprimary == "tribeam"
          opts["priweptypename"] ||= "tribeam"
          #opts["weaponcdtimer"] ||= 0.55
          #fires 3 at 45, 0, -45 angles
        end
        opts["secweptypename"] ||= "rocket"
        #opts["altweaponcdtimer"] ||= 0.65
        opts["turnspeed"] ||= 215.0
        opts["thrustspeed"] ||= 140.0
        #opts["reverseaccelrate"] ||= 100.0
        opts["maxspeed"] ||= 200.0
        opts["maxhealth"] ||= 10.0
        opts["maxspecial"] ||= 3.5
        super(opts)
      end
      
      def setup
        @shield_toggle_delay = 0.0
        super
      end
      
      def physics(dt, inputs)
        @shield_toggle_delay -= dt if @shield_toggle_delay > 0.0
        @shield_toggle_delay = 0.0 if @shield_toggle_delay < 0.0
        
        shield = get_shield
        shielding = true if shield
        shielding ||= false
        
        inputs.each do |input|
          case input.cmd
            when "special"
              if not shielding then
                if @curspecial >= 1.0 and @shield_toggle_delay <= 0.0 then
                  @shield_toggle_delay = 0.5
                  create_shield
                  shielding = true
                end
              else
                if @shield_toggle_delay <= 0.0 then
                  @shield_toggle_delay = 0.5
                  @stage.kill_by_id(shield.id)
                  shielding = false
                end
              end
          end
        end
        
        recharge_special(dt) unless shielding
        
        super(dt, inputs)
      end
      
      def to_s
        return "Pegasus " + super
      end
      
      def create_shield
        opts = Hash.new
        @stage.spawn("pegasusshield", opts, @teamid, @id, @x, @y, 0.0)
      end
      
      def get_shield
        @stage.get_by_shipid(@shipid).each do |e|
          return e if e.collideinfo[:shield]
        end
        return nil
      end
    end
  end
end