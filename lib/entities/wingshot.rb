require 'shot'

module StarshipKnights
  module Entities
    class WingShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 1.35, :firingangles => [-65.0, 65.0]}
      @firesound = "phaseralt"
      
      def configure(opts)
        opts["radius"] ||= 5.0
        if @teamid == 0 then
          opts["imagename"] ||= "wingshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "wingshotblue"
        end
        opts["lifetimer"] ||= 0.65
        opts["hits"] ||= 1
        opts["damage"] ||= 3.5
        opts["speed"] ||= 650.0
        opts["inheritance"] ||= 0.00
        
        super(opts)
      end
      
      def to_s
        return "WingShot " + super
      end
      
    end
  end
end