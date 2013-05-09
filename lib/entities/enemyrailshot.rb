require 'shot'

module StarshipKnights
  module Entities
    class EnemyRailShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 1.0}
      @firesound = "railgun"
      
      def configure(opts)
        opts["radius"] ||= 6.0
        if @teamid == 0 then
          opts["imagename"] ||= "railshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "railshotblue"
        end
        opts["lifetimer"] ||= 1.0
        opts["hits"] ||= 1
        opts["damage"] ||= 2.0
        opts["speed"] ||= 1000
        opts["inheritance"] ||= 0.0
        super(opts)
      end
      
      def to_s
        return "EnemyRailShot " + super
      end
      
    end
  end
end