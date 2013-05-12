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
      
      @portalwaves = Hash.new
      
      @nextwavedelay = 0
      @wavenum = 0
    end
    
    def openportal(x, y, wave)
      portalid = @battlestage.spawn("enemyportal", {"lifetimer" => wave.count*2.0}, 1, nil, x, y, 0)
      @portalwaves[portalid] = wave
    end
    
    def spawnfromportal(portalid)
      enemydef = @portalwaves[portalid].pop
      return unless enemydef
      portal = @battlestage.get_by_id(portalid)
      return unless portal
      shipid = portal.spawn(enemydef["klass"], enemydef["eopts"] || Hash.new)
      ai = AIPilots.all[enemydef["ai"]].new(shipid, @battlestage, *enemydef["aiopts"])
      
      @enemy_ais[shipid] = ai
      @enemy_ids << shipid
    end
    
    def update(dt)
      @nextwavedelay -= dt unless @nextwavedelay <= 0
      @enemy_ais.each_value do |ai|
        ai.think(dt) if @battlestage.get_by_id(ai.shipid)
      end
      cleanupdead
      checkonportals(dt)
      checkforalldead
    end
    
    def checkonportals(dt)
      dead = []
      @portalwaves.each_key do |id|
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
        if @wavenum <= @waves.count then
          if @nextwavedelay <= 0 then
            x = @battlestage.roll(@battlestage.xsize - 200) + 100
            y = @battlestage.roll(@battlestage.ysize - 200) + 100
            openportal(x, y, @waves[@wavenum])
            @wavenum += 1
            @nextwavedelay = 10
          end
        else
          @parent.winbattle
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