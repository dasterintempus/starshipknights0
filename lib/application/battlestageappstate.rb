require 'battlestage'
require 'battleai'

include Gosu
module StarshipKnights

  class BattleStageAppState < AppState
    
    attr_reader :battlestage, :pc
    attr_reader :camera_x, :camera_y, :viewport_x, :viewport_y
    
    def initialize(app, drawwidth, drawheight, enemies, conf=Hash.new)
      super(app, drawwidth, drawheight)
      @battlestage = BattleStage.new(self, conf)
      @pcid = $game.spawnplayership(@battlestage, 50, 50, 0)
      @enemy_ids = []
      @enemy_ais = Hash.new
      
      #DEBUG, REMOVE TO ENABLE ENEMIES
      #enemies = []
      
      enemies.each do |edef|
        eopts = edef["eopts"] || Hash.new
        aiopts = edef["aiopts"] || Hash.new
        
        params = edef["params"]
        
        id = @battlestage.spawn(edef["klass"], eopts, params["teamid"], nil, params["x"], params["y"], params["angle"])
        ai = BattleAI.new(id, @battlestage)
        edef["aipatterns"].each do |patternklass|
          ai.extend(AIPatterns.all[patternklass])
        end
        ai.configure(aiopts)
        ai.setup
        
        @enemy_ais[id] = ai
        @enemy_ids << id
      end
      
      @viewport_x = 800
      @viewport_y = 600
      
      @camera_x = 0
      @camera_y = 0
      
      @app.play_music("battle01", true)
    end
    
    def pc
      return @battlestage.get_by_id(@pcid)
    end
    
    def play_sound(name, x, y)
      pcx = @camera_x + @viewport_x/2
      pcy = @camera_y + @viewport_y/2
      dx = x - pcx
      pan = dx / 650.0
      #d = Util.distance(pcx, pcy, x, y)
      #return if d > 600.0
      #vol = (d / -750.0) + 1.0
      #return if vol < 0.0 or vol > 1.0
      vol = 1.0 - ((pcy - y).abs / 650.0)
      @app.play_sound(name, pan, vol)
    end
    
    def set_cam(x,y,center=true)
      if center then
        @camera_x = x - @viewport_x/2
        @camera_y = y - @viewport_y/2
      else
        @camera_x = x
        @camera_y = y
      end
    end
    
    def scroll_cam(x,y,center=true)
      if center then
        targ_x = x - @viewport_x/2
        targ_y = y - @viewport_y/2
      else
        targ_x = x
        targ_y = y
      end
      d = Util.distance(targ_x,targ_y,@camera_x,@camera_y)
      if d >= 200 then
        set_cam(targ_x,targ_y,false)
        #puts "Setting cam instead"
        return
      end
      @camera_x = 0.90 * @camera_x + 0.10 * targ_x
      @camera_y = 0.90 * @camera_y + 0.10 * targ_y
    end
    
    def update(dt)
      @enemy_ais.each_value do |ai|
        ai.think(dt)
      end
    
      @battlestage.tick(dt)
      
      set_cam(pc.x, pc.y)
      @camera_x = Util.clamp(@camera_x, 0, @battlestage.xsize - @viewport_x)
      @camera_y = Util.clamp(@camera_y, 0, @battlestage.ysize - @viewport_y)
    end
    
    def draw
      draw_hud
      @app.translate((@drawwidth-@viewport_x)/2.0, (@drawheight-@viewport_y)/2.0) do
        @battlestage.draw_bg
        @app.translate(-@camera_x,-@camera_y) do #ingame camera
          @battlestage.draw
          
          draw_bars
        end
      end
    end
    
    def button_down(id)
      if [Gosu::KbLeft, Gosu::KbA].include? id then
        add_input("left", "+")
      elsif [Gosu::KbRight, Gosu::KbD].include? id then
        add_input("right", "+")
      elsif [Gosu::KbUp, Gosu::KbW].include? id then
        add_input("thrust", "+")
      elsif [Gosu::KbDown, Gosu::KbS].include? id then
        add_input("rthrust", "+")
      elsif [Gosu::KbSpace, Gosu::KbJ, Gosu::KbNumpad1].include? id then
        add_input("fire","+")
      elsif [Gosu::KbLeftShift, Gosu::KbK, Gosu::KbNumpad2].include? id then
        add_input("altfire","+")
      elsif [Gosu::KbLeftControl, Gosu::KbL, Gosu::KbNumpad3].include? id then
        add_input("special","+")
      end
    end
    
    def button_up(id)
      if [Gosu::KbLeft, Gosu::KbA].include? id then
        add_input("left", "-")
      elsif [Gosu::KbRight, Gosu::KbD].include? id then
        add_input("right", "-")
      elsif [Gosu::KbUp, Gosu::KbW].include? id then
        add_input("thrust", "-")
      elsif [Gosu::KbDown, Gosu::KbS].include? id then
        add_input("rthrust", "-")
      elsif [Gosu::KbSpace, Gosu::KbJ, Gosu::KbNumpad1].include? id then
        add_input("fire", "-")
      elsif [Gosu::KbLeftShift, Gosu::KbK, Gosu::KbNumpad2].include? id then
        add_input("altfire", "-")
      elsif [Gosu::KbLeftControl, Gosu::KbL, Gosu::KbNumpad3].include? id then
        add_input("special","-")
      end
    end
    
    def add_input(cmd, mode)
      @battlestage.add_input(@pcid, cmd, mode)
    end
  
    def draw_bars
      @battlestage.get_all.each do |e|
        #$logger.debug { e.to_s }
        next unless e.is_ship
        next unless e.teamid == 0
        
        #puts e.inspect
      
        health = Float(e.health)
        maxhealth = Float(e.maxhealth)
        special = Float(e.curspecial)
        maxspecial = Float(e.maxspecial)
        
        healthratio = health / maxhealth
        barsize = 30.0 * healthratio
        @app.draw_rect(e.x - barsize/2.0, e.y-16, barsize, 2, 0x9900BC12, 25)
        return if maxspecial == 0.0 or special <= 0.0
        specialratio = special / maxspecial
        barsize = 30.0 * specialratio
        @app.draw_rect(e.x - barsize/2.0, e.y-14, barsize, 2, 0x99B200FF, 25)
      end
    end
  
    def draw_hud
      draw_minimap
      draw_status
      #draw_status_indicator
    end
    
    def draw_status
      @app.draw_rect(@drawwidth-232, @drawheight-18, 102, 18, 0x99FFFFFF, 25)
      
      health = Float(pc.health)
      maxhealth = Float(pc.maxhealth)
      special = Float(pc.curspecial)
      maxspecial = Float(pc.maxspecial)
      
      healthratio = health / maxhealth
      barsize = 98.0 * healthratio
      @app.draw_rect(@drawwidth-230, @drawheight-16, barsize, 6, 0x9900BC12, 25)
      
      return if maxspecial == 0.0 or special <= 0.0
      specialratio = special / maxspecial
      barsize = 98.0 * specialratio
      @app.draw_rect(@drawwidth-230, @drawheight-8, barsize, 6, 0x99B200FF, 25)
    end
  
    def draw_minimap
      minimap_x = 130
      minimap_y = Integer((Float(@battlestage.ysize)/Float(@battlestage.xsize)) * minimap_x)
      innermap_x = minimap_x - 4
      innermap_y = minimap_y - 4
      @app.draw_rect(@drawwidth-minimap_x, @drawheight-minimap_y, minimap_x, minimap_y, 0x99FFFFFF, 25)
      @app.draw_rect(@drawwidth-innermap_x-2, @drawheight-innermap_y-2, innermap_x, innermap_y, 0x99000000, 25)
      mine = @battlestage.get_by_shipid(@pcid)
      teamid = 0
      ents = @battlestage.get_all
      if ents != nil then
        #ships.delete_if {|x| i = x.info; not i.has_key? :ship or not i[:ship]} 
        ents.each do |e|
          shape = ""
          edi = e.drawinfo
          if e.is_ship then
            shape = "box"
            next if teamid != e.teamid and edi[:stealth]
            if mine.include? e then
              c = Gosu::Color::WHITE
            elsif e.teamid == 0
              c = 0xFFFF3300
            elsif e.teamid == 1
              c = 0xFF0094FF
            else
              c = Gosu::Color::YELLOW
            end
          end
          
          case shape
            when "box"
              x = e.x / Float(@battlestage.xsize) * innermap_x + @drawwidth-innermap_x-2
              y = e.y / Float(@battlestage.ysize) * innermap_y + @drawheight-innermap_y-2
              @app.draw_rect(x-1,y-1,2,2,c,25)
            when "+"
              x = (e.x / Float(@battlestage.xsize) * innermap_x) + @drawwidth-innermap_x-2
              y = (e.y / Float(@battlestage.ysize) * innermap_y) + @drawheight-innermap_y-2
              @app.draw_line(x-2, y, c, x+2, y, c, 26)
              @app.draw_line(x, y-2, c, x, y+2, c, 26)
            when "x"
              x = (e.x / Float(@battlestage.xsize) * innermap_x) + @drawwidth-innermap_x-2
              y = (e.y / Float(@battlestage.ysize) * innermap_y) + @drawheight-innermap_y-2
              @app.draw_line(x-2, y-2, c, x+2, y+2, c, 26)
              @app.draw_line(x-2, y+2, c, x+2, y-2, c, 26)
          end
        end
      end
    end
  
  end

end