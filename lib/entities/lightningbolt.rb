require 'shot'

module StarshipKnights
  module Entities
    class LightningBolt < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 1.15}
      @firesound = "phaseralt"
      
      def configure(opts)
        opts["radius"] ||= 6.0
        opts["imagename"] ||= "lightningbolt"
        opts["lifetimer"] ||= 0.35
        opts["hits"] ||= 1
        opts["damage"] ||= 3.0
        opts["speed"] ||= 1250.0
        opts["inheritance"] ||= 0.00
        
        super(opts)
      end
      
      def to_s
        return "LightningBolt " + super
      end
      
    end
  end
end