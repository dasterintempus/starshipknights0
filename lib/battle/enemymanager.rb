require 'allaipilots'

include Gosu
module StarshipKnights

  class EnemyManager
    attr_reader :nextspawnx, :nextspawny, :nextspawnt
    
    def initialize(parent, difficulty, battlestage, waves)
      @parent = parent
      @difficulty = difficulty
      @battlestage = battlestage
      @waves = waves
      
      @enemy_ids = Array.new
      @enemy_ais = Hash.new
      
      @portalgroups = Hash.new
      
      @nextwavedelay = 3.5
      @wavenum = -1
    end
    
    def startwave(wavedef)
      wavedef["portals"].each do |portaldef|
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
    end
    
    def spawnfromportal(portalid)
      spawngroup = @portalgroups[portalid].pop
      return unless spawngroup
      portal = @battlestage.get_by_id(portalid)
      return unless portal
      count = spawngroup["count"]
      count = (count*1.65).floor if $game.difficulty > 2
      count.times do
        shipid = portal.spawn(spawngroup["klass"], spawngroup["eopts"] || Hash.new)
        ai = AIPilots.all[spawngroup["ai"]].new(shipid, @battlestage, *spawngroup["aiopts"])
        
        @enemy_ais[shipid] = ai
        @enemy_ids << shipid
      end
    end
    
    def update(dt)
      @nextwavedelay -= dt if @nextwavedelay > 0 and alldead?
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
        end
      end
    end
    
    def cleanupdead
      @enemy_ais.keep_if { |k,v| @battlestage.get_by_id(k) }
    end
    
    def checkforalldead
      if alldead? then
        if @nextwavedelay <= 0 then
          @wavenum += 1
          $game.score += @waves[@wavenum-1]["score"] if @wavenum > 0
          if @wavenum < @waves.count then
            startwave(@waves[@wavenum])
            @nextwavedelay = 3.5
          else
            @parent.winbattle
          end
        end
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