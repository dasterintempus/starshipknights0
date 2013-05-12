require 'haslifetime'

module StarshipKnights
  module Entities
    class EnemyPortal < StarshipKnights::BattleEntity
      include StarshipKnights::Components::HasLifetime
      
      attr_reader :shipstospawn
      attr_accessor :nextspawntime
      
      def configure(opts)
        opts["radius"] ||= 100.0
        @opensound = opts["opensound"] || "portalopen"
        @spawnsound = opts["spawnsound"] || "portalspawn"
        @diesound = opts["diesound"] || "portaldie"
        opts["imagename"] ||= "portal"
        
        super(opts)
      end
      
      def setup
        play_sound(@opensound, @x, @y)
        #@spawntimer = @lifetimer / @shipstospawn.count
        #@spawntime = @spawntimer
        @nextspawntime = 0.0
        super
      end
      
      def spawn(shipname, opts=Hash.new)
        spawnangle = @stage.roll(360)
        spawndist = @stage.roll(150) + 15
        x = @x + Math.cos(Util.rad(spawnangle)) * spawndist
        y = @y + Math.sin(Util.rad(spawnangle)) * spawndist
        play_sound(@spawnsound, @x, @y)
        return @stage.spawn(shipname, opts, @teamid, nil, x, y, spawnangle)
      end
      
      def expire
        play_sound(@diesound, @x, @y)
        super
      end
      
      def to_s
        return "EnemyPortal " + super
      end
      
    end
  end
end