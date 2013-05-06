include Gosu
module StarshipKnights

  class BattleEntity
    #constructor defined
    attr_reader :id, :teamid, :shipid, :x, :y, :angle, :xvel, :yvel, :stage
    #configure defined
    attr_reader :imagename, :name, :radius
    #derived
    attr_reader :image, :text
    
    def initialize(stage, id, teamid, shipid, x, y, angle)
      @stage = stage
      @id = id
      @teamid = teamid
      @shipid = shipid
      @x = x
      @y = y
      @angle = angle
      #@xvel = 0
      #@yvel = 0
      @name = name
    end
    
    def setpos(x,y)
      @x = x
      @y = y
    end
    
    def setvel(x,y)
      @xvel = x
      @yvel = y
    end
    
    def play_sound(name, x, y)
      @stage.parent.play_sound(name, x, y)
    end
    
    def draw
      @image ||= @stage.parent.app.get_image(@imagename) if @imagename
      return unless @image
      ex = ey = @radius * 2.0
      sx = (ex / @image.width)
      sy = (ey / @image.height)
      
      pcteam = 0
      
      zorder = 5
      zorder += 1 if is_ship
      
      if drawinfo[:stealth] and pcteam == @teamid then
        @image.draw_rot(@x, @y, zorder, @angle, 0.5, 0.5, sx, sy, 0xFFAAAAAA)
      elsif drawinfo[:invis] and pcteam == @teamid then
        @image.draw_rot(@x, @y, zorder, @angle, 0.5, 0.5, sx, sy, 0x88FFFFFF)
      elsif drawinfo[:invis] and pcteam != @teamid then
        @image.draw_rot(@x, @y, zorder, @angle, 0.5, 0.5, sx, sy, 0x05FFFFFF)
      else
        @image.draw_rot(@x, @y, zorder, @angle, 0.5, 0.5, sx, sy)
      end
      
      return if pcteam != @teamid
      @text ||= Gosu::Image.from_text(@stage.parent.app, @name, "Arial", 12, 3, 100, :center) if @name
      return unless @text
      
      text_y = @y - 26
      @stage.parent.app.draw_rect(@x - (@text.width/4), text_y, @text.width/2, 14, 0x99FFFFFF, zorder+1)
      case @teamid
        when 0
          #friendly
          c = Gosu::Color::GREEN
        when 1
          #hostile
          c = Gosu::Color::RED
        when 2
          #neutral
          c = Gosu::Color::YELLOW
      end
      @text.draw(@x - (@text.width/2), text_y, zorder+2, 1.0, 1.0, c)
    end
    
    def rebuild_image
      @image = @stage.parent.app.get_image(@imagename) if @imagename
    end
    
    def is_ship
      return @id == @shipid
    end
    
    def configure(opts)
      @imagename = opts["imagename"]
      @radius = opts["radius"]
      @name = opts["name"]
    end
    
    def setup
    end
    
    def physics(dt, inputs)
      #puts "battleentity physics #{inputs}" if inputs.count > 0
    end
    
    def drawinfo
      return Hash.new
    end
    
    def collideinfo
      return Hash.new
    end
    
    def collide(other)
    end
  
  end
  
  module Entities
    def self.all
      out = Hash.new
    
      out["twinlasershot"] = StarshipKnights::Entities::TwinLaserShot
      out["wingshot"] = StarshipKnights::Entities::WingShot
      out["bomb"] = StarshipKnights::Entities::Bomb
      out["phoenix"] = StarshipKnights::Entities::Phoenix
      
      out["rapidshot"] = StarshipKnights::Entities::RapidShot
      out["spreadshot"] = StarshipKnights::Entities::SpreadShot
      out["kitsune"] = StarshipKnights::Entities::Kitsune
      
      out["ringshot"] = StarshipKnights::Entities::RingShot
      out["tribeam"] = StarshipKnights::Entities::TriBeam
      out["rocket"] = StarshipKnights::Entities::Rocket
      out["pegasusshield"] = StarshipKnights::Entities::PegasusShield
      out["pegasus"] = StarshipKnights::Entities::Pegasus
      
      out["waveshot"] = StarshipKnights::Entities::WaveShot
      out["disruptshot"] = StarshipKnights::Entities::DisruptShot
      out["chargeshot"] = StarshipKnights::Entities::ChargeShot
      out["wyvernshockwave"] = StarshipKnights::Entities::WyvernShockwave
      out["wyvern"] = StarshipKnights::Entities::Wyvern
      
      out["triangleshot"] = StarshipKnights::Entities::TriangleShot
      out["torpedo"] = StarshipKnights::Entities::Torpedo
      out["railcannon"] = StarshipKnights::Entities::RailCannon
      out["jotunn"] = StarshipKnights::Entities::Jotunn
      
      out["railshot"] = StarshipKnights::Entities::RailShot
      out["slowmine"] = StarshipKnights::Entities::SlowMine
      out["djinn"] = StarshipKnights::Entities::Djinn
      
      out["explosion"] = StarshipKnights::Entities::ExplosionReal
      #out["asteroid"] = StarshipKnights::Entities::Asteroid
    
      out["roundblock"] = StarshipKnights::Entities::RoundBlockEnemy
      
      return out
    end
  end
  
end