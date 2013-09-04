require 'appstate'

include Gosu
module StarshipKnights

  class LevelChangeAppState < AppState
    attr_reader :app, :drawwidth, :drawheight
    def initialize(app, drawwidth, drawheight, level)
      super(app, drawwidth, drawheight)
      @levelstr = "Level #{level.to_s}"
      @leveldraw = Gosu::Image.from_text(@app, @levelstr, "Arial", 26, 5, 200, :center)
      @textdraw = Gosu::Image.from_text(@app, "Press Key to Start", "Arial", 20, 5, 200, :center)
    end
    
    def draw
      @leveldraw.draw((@drawwidth-@leveldraw.width)/2.0, 100, 10)
      @textdraw.draw((@drawwidth-@textdraw.width)/2.0, 200, 10)
      @app.draw_rect(0, 0, @drawwidth, @drawheight, Gosu::Color.rgba(0,0,0,120), 9)
    end
    
    def update(dt)
    end
    
    def button_down(id)
      @app.pop_state
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