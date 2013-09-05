require 'shot'

module StarshipKnights
  module Entities
    class WaveShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.95}
      @firesound = "wave"
      
      def configure(opts)
        opts["radius"] ||= 7.0
        opts["imagename"] ||= "waveshot"
        opts["lifetimer"] ||= 0.65
        opts["hits"] ||= 1
        opts["damage"] ||= 1.75
        opts["speed"] ||= 350.0
        opts["inheritance"] ||= 0.00
        
        super(opts)
      end
      
      def collideinfo
        return super.merge({:shieldpen => true})
      end
      
      def collide(other)
        if other.teamid != teamid then
          oci = other.collideinfo
          if oci[:weapon] then
            @stage.kill_by_id(other.id)
            return
          end
        end
        super
      end
      
      def to_s
        return "WaveShot " + super
      end
      
    end
  end
end