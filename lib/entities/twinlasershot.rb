require 'shot'

module StarshipKnights
  module Entities
    class TwinLaserShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.35}
      @firesound = "pew"
      
      def configure(opts)
        opts["radius"] ||= 5.0
        opts["imagename"] ||= "twinlasershot"
        opts["lifetimer"] ||= 0.75
        opts["hits"] ||= 1
        opts["damage"] ||= 2.35
        opts["speed"] ||= 425.0
        opts["inheritance"] ||= 0.15
        
        super(opts)
      end
      
      def to_s
        return "TwinLaserShot " + super
      end
      
    end
  end
end