require 'ship'
require 'slider'
module StarshipKnights
  module Entities
    class Kitsune < StarshipKnights::EntityTypes::Ship
      include StarshipKnights::Components::Slider
    
      def configure(opts)
        opts["imagename"] ||= "kitsune"
        opts["priweptypename"] ||= "rapidshot"
        #opts["weaponcdtimer"] ||= 0.14
        opts["secweptypename"] ||= "spreadshot"
        #opts["altweaponcdtimer"] = 2.5
        #fires at 20, 10, 0, -10, 20 angles
        opts["turnspeed"] ||= 225.0
        opts["thrustspeed"] ||= 175.0
        opts["maxspeed"] ||= 225.0
        
        opts["maxhealth"] ||= 14.0
        
        if @equippedspecial == "slide" then
          opts["maxspecial"] ||= 5.0
          opts["slidespeed"] ||= 300.0
          opts["slidespecialdrainrate"] ||= 1.35
        elsif @equippedspecial == "reversemomentum"
          opts["maxspecial"] ||= 6.5
        end
        
        super(opts)
      end
      
      def physics(dt, inputs)
        #$logger.debug { "kitsune got inputs: " + inputs.inspect} if $logger
        if @equippedspecial == "slide" then
          #$logger.debug { "slide equipped" }
          @sliding = false
          #look for slide
          inputs.each do |input|
            case input.cmd
              when "special"
                if @curspecial > 0.1 then
                  #$logger.debug { "setting @sliding = true" }
                  @sliding = true
                end
            end
          end
          recharge_special(dt) unless @sliding
        elsif @equippedspecial == "reversemomentum"
          reversed = false
          inputs.each do |input|
            case input.cmd
              when "special"
                if @curspecial >= 6.5 then
                  @xvel = -@xvel
                  @yvel = -@yvel
                  #turn(180)
                  reversed = true
                  @curspecial = 0.0
                end
            end
          end
          recharge_special(dt) unless reversed
        end
        super(dt, inputs)
      end
      
      def to_s
        return "Kitsune " + super
      end
      
    end
  end
end