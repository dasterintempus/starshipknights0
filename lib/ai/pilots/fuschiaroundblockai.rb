require 'battleaipilot'
require 'util'
require 'aiutils'

include Gosu
module StarshipKnights
  module AIPilots
    class FuschiaRoundBlock < BattleAIPilot
    
      def initialize(shipid, battlestage, timertoturn=2.5)
        super(shipid, battlestage)
        @timertoturn = timertoturn
        @timetoturn = 0
      end
      
      def think(dt)
        super
        
        @timetoturn -= dt
        add_input("thrust")# if @timetoturn < @timertoturn/2.0
        #add_input("rthrust") if @timetoturn >= @timertoturn/2.0
        if @timetoturn <= 0.0
          @timetoturn = @timertoturn
          @newangle = (me.angle + 180.0) % 360.0
          me.turn(180.0)
        end
        
        fire_if_facing_pc(10.0)
      end
      
    end
  end
end
