require 'appstate'

include Gosu
module StarshipKnights

  class LevelChangeAppState < AppState
    attr_reader :app, :drawwidth, :drawheight
    def initialize(app, drawwidth, drawheight, level)
      super(app, drawwidth, drawheight)
      @levelstr = "Level #{level.to_s}"
      @leveldraw = Gosu::Image.from_text(@app, @levelstr, "Arial", 26, 5, 200, :center)
      @waittextdraw = Gosu::Image.from_text(@app, "Ready...", "Arial", 20, 5, 200, :center)
      @gotextdraw = Gosu::Image.from_text(@app, "Go!", "Arial", 20, 5, 200, :center)
      @timer = 3.0
    end
    
    def draw
      @leveldraw.draw((@drawwidth-@leveldraw.width)/2.0, 100, 10)
      if @timer > 1.0 then
        @waittextdraw.draw((@drawwidth-@waittextdraw.width)/2.0, 200, 10)
      else
        @gotextdraw.draw((@drawwidth-@gotextdraw.width)/2.0, 200, 10)
      end
      @app.draw_rect(0, 0, @drawwidth, @drawheight, Gosu::Color.rgba(0,0,0,120), 9)
    end
    
    def update(dt)
      @timer -= dt
      @app.pop_state if @timer <= 0
    end
    
    def button_down(id)
    end
    
    def button_up(id)
    end
    
    def show_behind
      return true
    end
    
    def on_active
    end
  end

end