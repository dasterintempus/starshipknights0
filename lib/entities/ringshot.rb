require 'shot'

module StarshipKnights
  module Entities
    class RingShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.7}
      @firesound = "pewalt"
      
      def configure(opts)
        opts["radius"] ||= 6.0
        opts["imagename"] ||= "ringshot"
        opts["firesound"] ||= "pewalt"
        opts["lifetimer"] ||= 0.9
        opts["hits"] ||= 3
        opts["damage"] ||= 1.0
        opts["speed"] ||= 500.0
        opts["inheritance"] ||= 0.1
        super(opts)
      end
      
      def to_s
        return "RingShot " + super
      end
      
    end
  end
end