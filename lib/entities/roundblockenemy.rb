require 'gliderenemy'
require 'slider'

module StarshipKnights
  module Entities
    class RoundBlockEnemy < StarshipKnights::EntityTypes::GliderEnemy
      include StarshipKnights::Components::Slider
      
      def configure(opts)
        @color = opts["color"] || "gray"
        opts["imagename"] ||= "rndblockenemy"+@color
        opts["priweptypename"] ||= "rapidshot"
        #opts["weaponcdtimer"] ||= 0.35
        #@altshottype = "spreadshot"
        opts["turnspeed"] ||= 225.0
        #opts["maxspeed"] ||= 225.0
        opts["forwardspeed"] ||= 200 #opts["maxspeed"] * 2.0/3.0
        opts["slidespeed"] ||= 150 #opts["maxspeed"] * 1.0/3.0
        opts["reversespeed"] ||= 120 #opts["maxspeed"] * 1.0/2.0
        #@next_cd = 0.14
        #@next_alt_cd = 0.75
        opts["maxhealth"] = 4.0
        opts["damage"] = 4.0
        super(opts)
      end
      
      def physics(dt, inputs)
        clear_vel
        
        #$logger.debug {"#{inspect} #{inputs}" }
        @sliding = false
        #look for slide
        inputs.each do |input|
          case input.cmd
            when "special"
              @sliding = true
          end
        end
        super(dt, inputs)
      end
      
      def to_s
        return "RoundBlockEnemy " + super
      end
      
    end
  end
end
