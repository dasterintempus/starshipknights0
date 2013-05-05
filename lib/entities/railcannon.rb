require 'shot'

module StarshipKnights
  module Entities
    class RailCannon < StarshipKnights::EntityTypes::Shot
      def self.shootingproperties
        return super.merge({:cooldown => 1.85})
      end
      
      def self.firesound
        return "railgun"
      end
      
      def configure(opts)
        opts["radius"] ||= 10.0
        if @teamid == 0 then
          opts["imagename"] ||= "railshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "railshotblue"
        end
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