require 'mine'

module StarshipKnights
  module Entities
    class SlowMine < StarshipKnights::EntityTypes::Mine
      def self.shootingproperties
        return super.merge({:cooldown => 5.0})
      end
    
      def self.firingsound
        return "slowmineplant"
      end
    
      def configure(opts)
        opts["radius"] ||= 8.0
        if @teamid == 0 then
          opts["imagename"] ||= "slowminered"
        elsif @teamid == 1 then
          opts["imagename"] ||= "slowmineblue"
        end
        opts["armingtimer"] ||= 0.35
        opts["triggersound"] ||= "slowmine"
        
        super(opts)
      end
      
      def trigger(other)
        #temporary
        other.hurt(1.0)
        
        #other.speed_debuff_time = 1.5
        #other.speed_debuff_mod = 0.35
      end
      
      def to_s
        return "SlowMine " + super
      end
    end
  end
end