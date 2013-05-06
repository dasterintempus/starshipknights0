require 'shot'

module StarshipKnights
  module Entities
    class DisruptShot < StarshipKnights::EntityTypes::Shot
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 0.75}
      @firesound = "wavealt2"
    
      attr_reader :disrupt
      def configure(opts)
        if @teamid == 0 then
          opts["imagename"] ||= "disruptshotred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "disruptshotblue"
        end
        opts["radius"] ||= 8.5
        opts["lifetimer"] ||= 0.75
        opts["hits"] ||= 1
        @disrupt = opts["disrupt"] || 1.35
        opts["speed"] ||= 450.0
        opts["inheritance"] ||= 0.10
        opts["damage"] ||= 0.5
        
        super(opts)
      end
      
      def info
        return super.merge({:disrupt => @disrupt})
      end
      
      def to_s
        return "DisruptShot " + super
      end
      
    end
  end
end