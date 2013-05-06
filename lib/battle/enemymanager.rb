require 'battleai'

include Gosu
module StarshipKnights

  class EnemyManager
    def initialize(parent, difficulty, battlestage, enemies)
      @parent = parent
      @difficulty = difficulty
      @battlestage = battlestage
      
      @enemy_ids = []
      @enemy_ais = Hash.new
      
      enemies.each do |edef|
        eopts = edef["eopts"] || Hash.new
        aiopts = edef["aiopts"] || Hash.new
        
        params = edef["params"]
        
        shipid = @battlestage.spawn(edef["klass"], eopts, params["teamid"], nil, params["x"], params["y"], params["angle"])
        ai = BattleAI.new(shipid, @battlestage)
        edef["aipatterns"].each do |patternklass|
          ai.extend(AIPatterns.all[patternklass])
        end
        ai.configure(aiopts)
        ai.setup
        
        @enemy_ais[shipid] = ai
        @enemy_ids << shipid
      end
    end
    
    def update(dt)
      @enemy_ais.each_value do |ai|
        ai.think(dt)
      end
      checkforalldead
    end
    
    def checkforalldead
      if alldead? then
        @parent.winbattle
      end
    end
    
    def alldead?
      @enemy_ids.each do |id|
        return false if @battlestage.get_by_id(id)
      end
      return true
    end 
  end

end