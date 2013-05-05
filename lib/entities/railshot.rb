require 'shot'

module StarshipKnights
  module Entities
    class RailShot < StarshipKnights::EntityTypes::Shot
      def self.shootingproperties
        return super.merge({:cooldown => 1.25})
      end
      
      def self.firingsound
        return "railgun"
      end
      
      def configure(opts)
        opts["radius"] ||= 6.0
        if @teamid == 0 then
          opts["imagename"] ||= "railshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "railshotblue"
        end
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