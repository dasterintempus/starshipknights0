require 'thrusterenemy'

module StarshipKnights
  module Entities
    class RayEnemy < StarshipKnights::EntityTypes::ThrusterEnemy
      
      def configure(opts)
        @color = opts["color"] || "cyan"
        opts["imagename"] ||= "rayenemy"+@color
        case @color
          when "cyan"
            opts["priweptypename"] ||= "enemyrailshot"
            opts["scorevalue"] ||= 35
        end
        opts["turnspeed"] ||= 30.0
        @maxturnspeed = opts["maxturnspeed"] || 60.0
        @minturnspeed = opts["minturnspeed"] || 15.0
        opts["maxspeed"] ||= 225.0
        opts["thrustspeed"] ||= 300.0
        opts["maspeed"] ||= 270.0
        #opts["forwardspeed"] ||= 200 #opts["maxspeed"] * 2.0/3.0
        #opts["slidespeed"] ||= 150 #opts["maxspeed"] * 1.0/3.0
        #opts["reversespeed"] ||= 120 #opts["maxspeed"] * 1.0/2.0
        opts["maxhealth"] = 3.0 + $game.difficulty * 1.0
        opts["damage"] = 4.5 + $game.difficulty * 1.0
        super(opts)
      end
      
      def physics(dt, inputs)
        @turnspeed = Util.clamp(@turnspeed, @minturnspeed, @maxturnspeed)
        super(dt, inputs)
      end
      
      def to_s
        return "RayEnemy " + super
      end
      
    end
  end
end
