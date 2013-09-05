require 'shot'

module StarshipKnights
  module Entities
    class RailShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 1.25}
      @firesound = "railgun"
      
      def configure(opts)
        opts["radius"] ||= 6.0
        opts["imagename"] ||= "railshot"
        opts["lifetimer"] ||= 1.0
        opts["hits"] ||= 1
        opts["damage"] ||= 2.75
        opts["speed"] ||= 1000
        opts["inheritance"] ||= 0.0
        super(opts)
      end
      
      def to_s
        return "RailShot " + super
      end
      
    end
  end
end