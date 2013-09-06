require 'shot'

module StarshipKnights
  module Entities
    class RapidShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.14}
      @firesound = "dak"
      
      def configure(opts)
        opts["imagename"] ||= "rapidshot"
        opts["radius"] ||= 3.0
        opts["lifetimer"] ||= 0.65
        opts["hits"] ||= 3
        opts["speed"] ||= 535.0
        opts["inheritance"] ||= 0.05
        opts["damage"] ||= 0.3
        
        super(opts)
      end
      
      def setup
        @angle += @stage.roll(-7.5..7.5) #spray

        super
      end
      
      def to_s
        return "RapidShot " + super
      end
      
    end
  end
end