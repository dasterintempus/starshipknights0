require 'shot'

module StarshipKnights
  module Entities
    class TriBeam < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.55, :firingangles => [-45, 0, 45]}
      @firesound = "doop"
      
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