require 'ship'

module StarshipKnights
  module Entities
    class Wyvern < StarshipKnights::EntityTypes::Ship
      
      #attr_reader :maxchargetime
      #attr_accessor :chargetime
      
      def configure(opts)
        opts["imagename"] ||= "wyvern"
        
        if @equippedprimary == "waveshot" then
          opts["priweptypename"] ||= "waveshot"
          #opts["weaponcdtimer"] ||= 0.95
        elsif @equippedprimary == "disruptshot"
          opts["priweptypename"] ||= "disruptshot"
          #opts["weaponcdtimer"] ||= 0.75
        end
        opts["secweptypename"] = "chargeshot"
        #opts["altweaponcdtimer"] ||= 1.75
        opts["turnspeed"] ||= 175.0
        opts["thrustspeed"] ||= 215.0
        #opts["reverseaccelrate"] ||= 180.0
        @shockwavethrustspeed = opts["shockwavethrustspeed"] || 1000.0
        opts["maxspeed"] ||= 215.0
        opts["maxhealth"] ||= 15.5
        opts["maxspecial"] ||= 5.0
        #@maxchargetime = opts["maxchargetime"] || 3.5
        #@soundreplaytimer = opts["soundreplaytimer"] || 0.25
        super(opts)
      end
      
      def setup
        #@chargetime = 0.0
        @orig_thrustspeed = @thrustspeed
        #@soundreplaytime = @soundreplaytimer

        super
      end
      
      def physics(dt, inputs)
        #charging = false
        @thrustspeed = @orig_thrustspeed
        
        shockwaving = false
        shockwave = get_shockwave
        shockwaving = true if shockwave
        
        inputs.each do |input|
          case input.cmd
            when "special"
              if @curspecial >= 5.0 and not shockwaving then
                @curspecial = 0.0
                shockwaving = true
                do_shockwave
              end
          end
        end
        
        if not shockwaving then
          #pass_inputs = []
          #inputs.each do |input|
          #  case input.cmd
          #    when "altfire"
          #      charge(dt)
          #      charging = true
          #    else
          #      pass_inputs << input
          #  end
          #end
          #
          recharge_special(dt)
          
          #super(dt, pass_inputs)
          super(dt, inputs)
        else
          @thrustspeed = @shockwavethrustspeed
          super(dt, [InputEvent.new("thrust", "")]) #NO CONTROLS. THRUST ONLY. FINAL DESTINATION.
        end
        
        #fire_charge if not charging and @chargetime > 0.0
      end
      
      def to_s
        return "Wyvern " + super
      end
      
      #def charge(dt)
      #  @chargetime += dt
      #  @chargetime = @maxchargetime if @chargetime > @maxchargetime
      #  @soundreplaytime -= dt
      #  if @soundreplaytime <= 0.0 then
      #    @soundreplaytime = @soundreplaytimer
      #    play_sound("charging", @x, @y)
      #  end
      #end
      
      #def fire_charge
      #  opts = Hash.new
      #  opts["chargetime"] = @chargetime
      #  @chargetime = 0.0
      #  sec_fire(opts)
      #end
      
      def do_shockwave
        y = @x + Math.cos(Util.rad(@angle)) * 10.0
        x = @y + Math.sin(Util.rad(@angle)) * 10.0
        opts = Hash.new
        @stage.spawn("wyvernshockwave", opts, @teamid, @id, x, y, @angle)
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