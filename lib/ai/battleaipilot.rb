require 'statemachine'
require 'battleaistate'
require 'allaistates'

include Gosu
module StarshipKnights
  class BattleAIPilot
    include StarshipKnights::StateMachine
    attr_accessor :shipid, :battlestage
    
    def initialize(shipid, battlestage)
      init_statemachine
      AIStates.all.each do |k, v|
        @sm_states[k] = v.new(self)
      end
      @shipid = shipid
      @battlestage = battlestage
    end
    
    def add_input(cmd, mode="")
      @battlestage.add_input(@shipid, cmd, mode)
    end
    
    def think(dt)
      current_state.think(dt) if current_state
    end
    
    def me
      return @battlestage.get_by_id(@shipid)
    end
  end
  
end