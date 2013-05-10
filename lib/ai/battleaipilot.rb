require 'aiutils'

include Gosu
module StarshipKnights
  class BattleAIPilot
    attr_accessor :shipid, :battlestage
    
    def initialize(shipid, battlestage)
      @shipid = shipid
      @battlestage = battlestage
    end
    
    def add_input(cmd, mode="")
      @battlestage.add_input(@shipid, cmd, mode)
    end
    
    def think(dt)
    end
    
    def me
      return @battlestage.get_by_id(@shipid)
    end
    
    def fire_if_facing_pc(accfuzz=10)
      return unless AIUtils.find_player_ship(@battlestage) and me
      add_input("fire") if AIUtils.is_aimed_at(me, AIUtils.find_player_ship(@battlestage), accfuzz)
    end
  end
  
end