require 'battleaipilot'
require 'util'
require 'aiutils'

include Gosu
module StarshipKnights
  module AIPilots
    class Simple < BattleAIPilot
    
      def initialize(shipid, battlestage, state)
        super(shipid, battlestage)
        change_state(state)
      end
      
      def think(dt)
        super
        
        return unless AIUtils.find_player_ship(@battlestage) and me
        add_input("fire") if AIUtils.is_aimed_at(me, AIUtils.find_player_ship(@battlestage))
      end
      
    end
  end
end