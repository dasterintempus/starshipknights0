require 'shot'

module StarshipKnights
  module Entities
    class EnemyRapidShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.15}
      @firesound = "dak"
      
      def configure(opts)
        if @teamid == 0 then
          opts["imagename"] ||= "rapidshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "rapidshotblue"
        end
        opts["radius"] ||= 3.0
        opts["lifetimer"] ||= 0.65
        opts["hits"] ||= 2
        opts["speed"] ||= 535.0
        opts["inheritance"] ||= 0.05
        opts["damage"] ||= 0.25 + $game.difficulty * 0.05
        
        super(opts)
      end
      
      def setup
        @angle += @stage.roll(-7.5..7.5) #spray

        super
      end
      
      def to_s
        return "EnemyRapidShot " + super
      end
      
    end
  end
end