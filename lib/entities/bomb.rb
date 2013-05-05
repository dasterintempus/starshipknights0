require 'missile'

module StarshipKnights
  module Entities
    class Bomb < StarshipKnights::EntityTypes::Missile
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 2.0}
      @firesound = "fireball"
      
      def configure(opts)
        opts["radius"] ||= 6.5
        if @teamid == 0 then
          opts["imagename"] ||= "bombred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "bombblue"
        end
        #@firesound = "missilelaunch"
        opts["inheritance"] ||= 1.0
        opts["thrustspeed"] ||= 0
        opts["max_speed"] ||= 750.0
        opts["damage"] ||= 3.0
        opts["blastsize"] ||= 40.0
        opts["lifetimer"] ||= 2.0
        super(opts)
      end
      
      def to_s
        return "Bomb " + super
      end
      
    end
  end
end