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
        
        @turntime = 0.0
        @lastturndir = 1
      end
      
      def think(dt)
        super
        @turntimer ||= 180.0/me.turnspeed if me
        
        if @turntime > 0.0 then #turning left
          @turntime -= dt
          @turntime = 0.0 if @turntime < 0.0
          #add_input("left")
        elsif @turntime < 0.0 then #turning right
          @turntime += dt
          @turntime = 0.0 if @turntime > 0.0
          #add_input("left")
        else
          @timetoturn -= dt
          add_input("thrust")# if @timetoturn < @timertoturn/2.0
          #add_input("rthrust") if @timetoturn >= @timertoturn/2.0
          if @timetoturn <= 0.0
            @timetoturn = @timertoturn
            @turntime = @lastturndir * @turntimer
            me.turn(180.0)
            @lastturndir = -@lastturndir
          end
        end
        
        fire_if_facing_pc(5.0)
      end
      
    end
  end
end
