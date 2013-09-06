require 'ship'

module StarshipKnights
  module Entities
    class Phoenix < StarshipKnights::EntityTypes::Ship
    
      attr_reader :afterburnthrustspeed, :afterburnmaxspeed
      
      def configure(opts)
        opts["imagename"] ||= "phoenix"
        opts["priweptypename"] = "twinlasershot"
        #opts["weaponcdtimer"] = 0.35
        if @equippedsecondary == "wingshot" then
          opts["secweptypename"] ||= "wingshot"
          #opts["altweaponcdtimer"] ||= 1.35
          #fires at -65, 65 angles
        elsif @equippedsecondary == "bomb"
          opts["secweptypename"] ||= "bomb"
          #opts["altweaponcdtimer"] ||= 2.0
        end
        opts["turnspeed"] ||= 250.0
        opts["thrustspeed"] ||= 150.0
        #opts["reverseaccelrate"] ||= 120.0
        @afterburnthrustspeed = opts["afterburnthrustspeed"] || 750.0
        opts["maxspeed"] ||= 250.0
        @afterburnmaxspeed = opts["afterburnmaxspeed"] || 500.0
        opts["maxhealth"] ||= 13.5
        opts["maxspecial"] ||= 3.5
        
        @soundreplaytimer = opts["soundreplaytimer"] || 0.35
        super(opts)
      end
      
      def setup
        @orig_thrustspeed = @thrustspeed
        @orig_maxspeed = @maxspeed
        @soundreplaytime = @soundreplaytimer
        super
      end
      
      def physics(dt, inputs)
        @maxspeed = @orig_maxspeed
        @thrustspeed = @orig_thrustspeed
        
        afterburning = false
        found_thrust = false
        #turn = 0
        inputs.each do |input|
          case input.cmd
            when "special"
              if @curspecial >= 0.1 then
                @maxspeed = @afterburnmaxspeed
                @thrustspeed = @afterburnthrustspeed
                afterburning = true
                drain_special(dt, 1.0)
              end
            when "thrust"
              found_thrust = true
          end
        end
        
        recharge_special(dt) unless afterburning
        
        if afterburning and @curspecial > 0.1 then
          spawn_afterblast
          
          @soundreplaytime -= dt
          if @soundreplaytime <= 0 then
            @soundreplaytime = @soundreplaytimer
            play_sound("afterburn", @x, @y)
          end
        else
          @soundreplaytime = @soundreplaytimer
        end
        
        inputs << InputEvent.new("thrust", "") if afterburning and not found_thrust
        
        super(dt, inputs)
      end
      
      def to_s
        return "Phoenix " + super
      end

      def spawn_afterblast
        dx = Math.cos(Util.rad(@angle)) * 20.0
        dy = Math.sin(Util.rad(@angle)) * 20.0
        x = @x - dx
        y = @y - dy
        
        opts = Hash.new
        opts["radius"] = 45.0
        opts["damage"] = 0.1
        @stage.spawn("explosion", opts, @teamid, @id, x, y, 0.0)
      end
      
    end
  end
end