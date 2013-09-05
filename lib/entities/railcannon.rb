require 'shot'

module StarshipKnights
  module Entities
    class RailCannon < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 1.85}
      @firesound = "railgun"
      
      def configure(opts)
        opts["radius"] ||= 10.0
        opts["imagename"] ||= "railshot"
        opts["lifetimer"] ||= 1.25
        opts["hits"] ||= 1
        opts["damage"] ||= 3.75
        opts["speed"] ||= 900
        opts["inheritance"] ||= 0.0
        super(opts)
      end
      
      def to_s
        return "RailCannon " + super
      end
      
    end
  end
end