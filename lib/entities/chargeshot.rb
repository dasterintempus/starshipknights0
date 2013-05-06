require 'shot'

module StarshipKnights
  module Entities
    class ChargeShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound, :chargesound
      end
      @shootingproperties = {:charging => 3.5, :cooldown => 1.75}
      @firesound = "phaser"
      @chargesound = "charging"
    
      def configure(opts)
        if @teamid == 0 then
          opts["imagename"] ||= "chargeshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "chargeshotblue"
        end
        opts["lifetimer"] ||= 0.35 + opts["chargedtime"] / 7.0
        opts["radius"] ||= 2.0 + opts["chargedtime"] * 2.0
        opts["damage"] ||= 1.0 + opts["chargedtime"] * 1.35
        opts["hits"] ||= 1
        opts["speed"] ||= 350.0 + opts["chargedtime"] * 7.5
        opts["inheritance"] ||= 0.10
        super(opts)
      end
      
      def to_s
        return "ChargeShot " + super
      end
      
    end
  end
end