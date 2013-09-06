require 'appmenustate'
require 'gamediffselectmenustate'

include Gosu
module StarshipKnights

  class GameLoadoutSelectState < AppState
    
    def initialize(app, drawwidth, drawheight)
      super(app, drawwidth, drawheight)
      
      @cursor_img = Gosu::Image.new(@app, "./gfx/menu_cursor.png", false)
      @fields = []
      Loadout.__send__("#{$game.shipname.downcase}_loadout").each_value do |loadoutline|
        field = []
        loadoutline.each do |loadoutopt|
          field << { "option" => loadoutopt, "image" => Gosu::Image.from_text(@app, loadoutopt, "Arial", 18, 5, 200, :left) }
        end
        @fields << field
      end
      @selected = [0,0,0]
      @cursorline = 0
      @titletext = Gosu::Image.from_text(@app, "Loadout", "Arial", 32, 5, 200, :left)
    end
    
    def draw
      @titletext.draw(@drawwidth/3.0, (@drawheight/(@fields.length+2)), 50)
      yn = 1
      xn = 1
      @fields.each do |field|
        field.each do |entry|
          x = (@drawheight/(3)) * xn
          y = (@drawheight/(@fields.length+2)) * (yn+1)
          entry["image"].draw(x, y, 10)
          if @selected[yn-1] == xn-1 then
            if @cursorline == yn-1 then
              @cursor_img.draw(x-30, y, 35)
            else
              @cursor_img.draw(x-30, y, 35, 1.0, 1.0, Gosu::Color.rgba(125,125,125,255))
            end
          end
          xn+=1
        end
        xn = 1
        yn+=1
      end
    end
    
    def button_down(id)
      case id
      when Gosu::KbEscape
        @app.play_sound("menufail")
        @app.pop_state
      when Gosu::KbLeftShift
        @app.play_sound("menufail")
        @app.pop_state
      when Gosu::KbNumpad2
        @app.play_sound("menufail")
        @app.pop_state
      when Gosu::KbDown
        arrow_down
      when Gosu::KbUp
        arrow_up
      when Gosu::KbRight
        arrow_right
      when Gosu::KbLeft
        arrow_left
      when Gosu::KbS
        arrow_down
      when Gosu::KbW
        arrow_up
      when Gosu::KbD
        arrow_right
      when Gosu::KbA
        arrow_left
      when Gosu::KbReturn
        @app.play_sound("menuok")
        menudone
      when Gosu::KbSpace
        @app.play_sound("menuok")
        menudone
      when Gosu::KbNumpad1
        @app.play_sound("menuok")
        menudone
      end
    end
    
    def arrow_right
      @selected[@cursorline] += 1
      if @selected[@cursorline] > @fields[@cursorline].length-1 then
        @selected[@cursorline] = @fields[@cursorline].length-1
        @app.play_sound("menufail")
      else
        @app.play_sound("menublip")
      end
    end
    
    def arrow_left
      @selected[@cursorline] -= 1
      if @selected[@cursorline] < 0 then
        @selected[@cursorline] = 0
        @app.play_sound("menufail")
      else
        @app.play_sound("menublip")
      end
    end
    
    def arrow_down
      @cursorline += 1
      if @cursorline > @fields.length-1 then
        @cursorline = @fields.length-1
        @app.play_sound("menufail")
      else
        @app.play_sound("menublip")
      end
    end
    
    def arrow_up
      @cursorline -= 1
      if @cursorline < 0 then
        @cursorline = 0 
        @app.play_sound("menufail")
      else
        @app.play_sound("menublip")
      end
    end
  
    def menudone
      opts = []
      n = 0
      @selected.each do |sel|
        opts << @fields[n][sel]["option"]
        n+=1
      end
      $game.playeractiveship.equip(opts)
      @app.pop_state
      @app.add_state GameDiffSelectMenuState.new(@app, @drawwidth, @drawheight)
    end
  end
  
end