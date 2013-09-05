require 'battleaipilot'
require 'util'
require 'aiutils'

include Gosu
module StarshipKnights
  module AIPilots
    class CyanRay < BattleAIPilot
    
      def initialize(shipid, battlestage, turnacceltimer=5, turnaccel=5)
        super(shipid, battlestage)
        @turnacceltimer = turnacceltimer
        @turnacceltime = 0
        @turnaccel = turnaccel
        @turnacceling = false
        @cyclestoturn = 0
        @turnright = true
        
        #@turntime = 0.0
        
        #@lastturndir = 1
      end
      
      def think(dt)
        super
        @turnacceltime += dt
        if @turnacceltime >= @turnacceltimer then
          @turnacceltime = 0
          @turnacceling = !@turnacceling
          @cyclestoturn += 1
          if @cyclestoturn >= 2 then
            @cyclestoturn = 0
            @turnright = !@turnright
          end
        end
        
        if @turnacceling then
          me.turnspeed += @turnaccel * dt
        else
          me.turnspeed -= @turnaccel * dt
        end
        
        if @turnright then
          add_input("right")
        else
          add_input("left")
        end
        
        add_input("thrust")
        
        fire_if_facing_pc(5.0)
      end
      
    end
  end
end
