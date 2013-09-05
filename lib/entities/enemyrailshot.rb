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
        opts["imagename"] ||= "railshot"
        opts["lifetimer"] ||= 1.0
        opts["hits"] ||= 1
        opts["damage"] ||= 1.0 + $game.difficulty * 0.15
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