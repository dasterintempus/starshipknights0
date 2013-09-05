require 'ship'

module StarshipKnights
  module Entities
    class Thunderbird < StarshipKnights::EntityTypes::Ship
    
      attr_reader :afterburnthrustspeed, :afterburnmaxspeed
      
      def configure(opts)
        opts["imagename"] ||= "thunderbird"
        opts["priweptypename"] ||= "lightningbolt"
        #opts["weaponcdtimer"] = 0.35
        #if @equippedsecondary == "wingshot" then
          #opts["secweptypename"] ||= "wingshot"
          #opts["altweaponcdtimer"] ||= 1.35
          #fires at -65, 65 angles
        #elsif @equippedsecondary == "bomb"
          #opts["secweptypename"] ||= "bomb"
          #opts["altweaponcdtimer"] ||= 2.0
        #end
        opts["turnspeed"] ||= 250.0
        opts["thrustspeed"] ||= 150.0
        #opts["reverseaccelrate"] ||= 120.0
        @shockwavethrustspeed = opts["shockwavethrustspeed"] || 875.0
        opts["maxspeed"] ||= 250.0
        @shockwavemaxspeed = opts["shockwavemaxspeed"] || 600.0
        opts["maxhealth"] ||= 13.5
        opts["maxspecial"] ||= 3.5
        
        #@soundreplaytimer = opts["soundreplaytimer"] || 0.35
        super(opts)
      end
      
      def setup
        @orig_thrustspeed = @thrustspeed
        @orig_maxspeed = @maxspeed
        #@soundreplaytime = @soundreplaytimer
        super
      end
      
      def physics(dt, inputs)
        @maxspeed = @orig_maxspeed
        @thrustspeed = @orig_thrustspeed
        
        shockwaving = false
        shockwave = get_shockwave
        shockwaving = true if shockwave
        
        inputs.each do |input|
          case input.cmd
            when "special"
              if @curspecial >= 3.5 and not shockwaving then
                @curspecial = 0.0
                shockwaving = true
                do_shockwave
              end
          end
        end
        
        if not shockwaving then
          recharge_special(dt)
        else
          @thrustspeed = @shockwavethrustspeed
          @maxspeed = @shockwavemaxspeed
          inputs << InputEvent.new("thrust", "") #always thrust during shockwave
        end
        
        super(dt, inputs)
      end
      
      def to_s
        return "Thunderbird " + super
      end
      
      def do_shockwave
        y = @x + Math.cos(Util.rad(@angle)) * 10.0
        x = @y + Math.sin(Util.rad(@angle)) * 10.0
        opts = Hash.new
        @stage.spawn("thunderbirdshockwave", opts, @teamid, @id, x, y, @angle)
      end
      
      def get_shockwave
        @stage.get_by_shipid(@shipid).each do |e|
          return e if e.collideinfo[:shockwave]
        end
        return nil
      end
      
    end
  end
end