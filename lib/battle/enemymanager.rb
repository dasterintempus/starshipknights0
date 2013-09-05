require 'allaipilots'

include Gosu
module StarshipKnights

  class EnemyManager
    attr_reader :nextspawnx, :nextspawny, :nextspawnt
    
    def initialize(parent, difficulty, battlestage, leveldef)
      @parent = parent
      @difficulty = difficulty
      @battlestage = battlestage
      @leveldef = leveldef
      
      @enemy_ids = Array.new
      @enemy_ais = Hash.new
      
      @portalgroups = Hash.new
      @portalsopen = 0
      startlevel
    end
    
    def startlevel
      @leveldef["portals"].each do |portaldef|
        x = portaldef["x"]
        y = portaldef["y"]
        x = @battlestage.xsize + x if x < 0
        y = @battlestage.ysize + y if y < 0
        openportal(x, y, portaldef["spawns"])
      end
    end
    
    def openportal(x, y, spawngroups)
      portalid = @battlestage.spawn("enemyportal", {"lifetimer" => spawngroups.count*1.5}, 1, nil, x, y, 0)
      @portalgroups[portalid] = spawngroups
      @portalsopen += 1
    end
    
    def spawnfromportal(portalid)
      spawngroup = @portalgroups[portalid].pop
      return unless spawngroup
      portal = @battlestage.get_by_id(portalid)
      return unless portal
      count = spawngroup["count"]
      count = (count*1.65).floor if $game.difficulty > 2
      count.times do
        eopts = {"color" => spawngroup["color"]}
        shipid = portal.spawn(spawngroup["klass"], eopts || Hash.new)
        ai = AIPilots.all[spawngroup["klass"]][spawngroup["color"]].new(shipid, @battlestage)
        
        @enemy_ais[shipid] = ai
        @enemy_ids << shipid
      end
    end
    
    def update(dt)
      @enemy_ais.each_value do |ai|
        ai.think(dt) if @battlestage.get_by_id(ai.shipid)
      end
      cleanupdead
      checkonportals(dt)
      checkforalldead
    end
    
    def checkonportals(dt)
      dead = []
      @portalgroups.each_key do |id|
        portal = @battlestage.get_by_id(id)
        if portal then
          if portal.lifetimer/portal.lifetime >= 2 then
            portal.nextspawntime -= dt
            if portal.nextspawntime <= 0 then
              spawnfromportal(id)
              portal.nextspawntime = 0.35
            end
          end
        else
          dead << id
          @portalsopen -= 1
        end
      end
      dead.each do |portal|
        @portalgroups.delete(portal)
      end
    end
    
    def cleanupdead
      @enemy_ais.keep_if { |k,v| @battlestage.get_by_id(k) }
    end
    
    def checkforalldead
      #puts @portalsopen
      if alldead? then
        @parent.winbattle if @portalsopen == 0
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