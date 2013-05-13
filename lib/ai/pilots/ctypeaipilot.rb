require 'battleaipilot'
require 'util'
require 'aiutils'

include Gosu
module StarshipKnights
  module AIPilots
    class CType < BattleAIPilot
    
      def initialize(shipid, battlestage, lowturntimer=1.0, highturntimer=2.5)
        super(shipid, battlestage)
        @lowturntimer = lowturntimer
        @highturntimer = highturntimer
        @timetoturn = 0
      end
      
      def think(dt)
        super
        @newangle ||= me.angle
        
        if me.angle == @newangle then #turning
          @timetoturn -= dt
          add_input("thrust")
          if @timetoturn <= 0.0
            @timetoturn = @battlestage.roll(@highturntimer - @lowturntimer) + @lowturntimer
            @newangle = @battlestage.roll(360)
            me.turn_to(@newangle)
          end
        end
        
        fire_if_facing_pc(10.0)
      end
      
    end
  end
end
