require 'missile'

module StarshipKnights
  module Entities
    class Rocket < StarshipKnights::EntityTypes::Missile
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.65}
      @firesound = "missilelaunch"
      
      def configure(opts)
        opts["radius"] ||= 5.5
        if @teamid == 0 then
          opts["imagename"] ||= "rocketred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "rocketblue"
        end
        opts["blastsound"] ||= "missileblastalt"
        opts["lifetimer"] ||= 1.5
        opts["damage"] ||= 2.5
        opts["blastsize"] ||= 45.0
        opts["thrustspeed"] ||= 200.0
        opts["maxspeed"] ||= 450.0
        super(opts)
      end
      
      def setup
        @anglevel = @stage.roll(-50.0..50.0)
        
        super
      end
      
      def to_s
        return "Rocket " + super
      end
      
    end
  end
end