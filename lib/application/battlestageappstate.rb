require 'battlestage'
require 'enemymanager'

include Gosu
module StarshipKnights

  class BattleStageAppState < AppState
    
    attr_reader :battlestage, :pcid
    attr_reader :camera_x, :camera_y, :viewport_x, :viewport_y
    
    def initialize(app, drawwidth, drawheight)
      super(app, drawwidth, drawheight)
      @battlestage = BattleStage.new(self, "night-sky.jpg")
      @pcid = $game.spawnplayership(@battlestage, @battlestage.xsize/2.0, @battlestage.ysize*2.0/3.0, 270)
      @enemymanager = EnemyManager.new(self, $game.difficulty, @battlestage, $game.generatelevel(@battlestage.xsize, @battlestage.ysize))
      
      @viewport_x = drawwidth
      @viewport_y = drawheight
      
      @camera_x = 0
      @camera_y = 0
      
      @scoretagimg = Gosu::Image.from_text(@app, "Score:", "./font/PressStart2P.ttf", 14, 2, 100, :left)
      
      set_cam(@battlestage.xsize/2.0, @battlestage.ysize*2.0/3.0)
      
      @app.play_music("battle01", true)
    end
    
    def pc
      ship = @battlestage.get_by_id(@pcid)
      return ship
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
    
    def winbattle
      $game.winbattle
      @app.stop_music
      @app.pop_state
    end
    
    def losebattle
      $game.losebattle
      @app.stop_music
      @app.pop_state
      @app.add_state GameOverMenuState.new(@app, @drawwidth, @drawheight)
    end
    
    def set_cam(x,y,center=true)
      if center then
        @camera_x = x - @viewport_x/2
        @camera_y = y - @viewport_y/2
      else
        @camera_x = x
        @camera_y = y
      end
      
      @camera_x = Util.clamp(@camera_x, 0, @battlestage.xsize - @viewport_x)
      @camera_y = Util.clamp(@camera_y, 0, @battlestage.ysize - @viewport_y)
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
      
      @camera_x = Util.clamp(@camera_x, 0, @battlestage.xsize - @viewport_x)
      @camera_y = Util.clamp(@camera_y, 0, @battlestage.ysize - @viewport_y)
    end
    
    def update(dt)
    
      @battlestage.tick(dt)
    
      unless pc then
        losebattle
        return
      end
      
      @enemymanager.update(dt)
      
      set_cam(pc.x, pc.y)
    end
    
    def draw
      draw_hud
      @app.translate((@drawwidth-@viewport_x)/2.0, (@drawheight-@viewport_y)/2.0) do
        @battlestage.draw_bg
        @app.translate(-@camera_x,-@camera_y) do #ingame camera
          @battlestage.draw
          
          draw_bars if pc
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
      elsif [Gosu::KbSpace, Gosu::KbNumpad1].include? id then
        add_input("fire","+")
      elsif [Gosu::KbLeftShift, Gosu::KbNumpad2].include? id then
        add_input("altfire","+")
      elsif [Gosu::KbLeftControl, Gosu::KbNumpad3].include? id then
        add_input("special","+")
      elsif [Gosu::KbX].include? id then
        add_input("brake","+")
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
      elsif [Gosu::KbX].include? id then
        add_input("brake","-")
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
      draw_status if pc
      draw_score
      #draw_status_indicator
    end
    
    def draw_score
      realscore = $game.score + $game.tempscore
      textimg = Gosu::Image.from_text(@app, realscore.to_s, "./font/PressStart2P.ttf", 14, 2, 100, :right)
      @scoretagimg.draw(0, 0, 10)
      textimg.draw(110, 0, 10)
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
          next if edi[:stealth] and not mine.include? e
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