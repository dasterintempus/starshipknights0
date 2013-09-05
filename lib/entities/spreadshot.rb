require 'shot'

module StarshipKnights
  module Entities
    class SpreadShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 2.5, :firingangles => [-20, -10, 0, 10, 20]}
      @firesound = "wavealt"
      
      def configure(opts)
        opts["radius"] ||= 4.5
        opts["imagename"] ||= "spreadshot"
        opts["lifetimer"] ||= 0.35
        opts["hits"] ||= 1
        opts["damage"] ||= 1.15
        opts["speed"] ||= 450.0
        opts["inheritance"] ||= 0.0
        
        super(opts)
      end
      
      def to_s
        return "SpreadShot " + super
      end
      
    end
  end
end