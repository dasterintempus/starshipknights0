require 'shot'

module StarshipKnights
  module Entities
    class TriangleShot < StarshipKnights::EntityTypes::Shot
      def self.shootingproperties
        return super.merge({:cooldown => 0.45})
      end
      
      def self.firesound
        return "doop"
      end
      
      def configure(opts)
        opts["radius"] ||= 5.5
        if @teamid == 0 then
          opts["imagename"] ||= "triangleshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "triangleshotblue"
        end
        opts["lifetimer"] ||= 0.35
        opts["hits"] ||= 1
        opts["damage"] ||= 3.0
        opts["speed"] ||= 550.0
        opts["inheritance"] ||= 0.175
        
        super(opts)
      end
      
      def to_s
        return "TriangleShot " + super
      end
      
    end
  end
end