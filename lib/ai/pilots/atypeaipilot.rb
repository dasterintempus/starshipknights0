require 'battleaipilot'
require 'util'
require 'aiutils'

include Gosu
module StarshipKnights
  module AIPilots
    class AType < BattleAIPilot
    
      def initialize(shipid, battlestage, timertoturn=2.5)
        super(shipid, battlestage)
        @timertoturn = timertoturn
        @timetoturn = 0
        
        #@turntime = 0.0
        
        #@lastturndir = 1
      end
      
      def think(dt)
        super
        #@turntimer ||= 180.0/me.turnspeed if me
        @newangle ||= me.angle
        
        if me.angle == @newangle then #turning
          @timetoturn -= dt
          add_input("thrust")# if @timetoturn < @timertoturn/2.0
          #add_input("rthrust") if @timetoturn >= @timertoturn/2.0
          if @timetoturn <= 0.0
            @timetoturn = @timertoturn
            @newangle = (me.angle + 180.0) % 360.0
            me.turn(180.0)
          end
        end
        
        fire_if_facing_pc(5.0)
      end
      
    end
  end
end
