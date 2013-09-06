require 'shot'

module StarshipKnights
  module Entities
    class EnemyTriangleShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.65}
      @firesound = "doop"
      
      def configure(opts)
        opts["radius"] ||= 5.5
        opts["imagename"] ||= "enemytriangleshot"
        opts["lifetimer"] ||= 0.45
        opts["hits"] ||= 1
        opts["damage"] ||= 1.5 + $game.difficulty * 0.10
        opts["speed"] ||= 550.0
        opts["inheritance"] ||= 0.175
        
        super(opts)
      end
      
      def to_s
        return "EnemyTriangleShot " + super
      end
      
    end
  end
end