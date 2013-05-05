include Gosu
module StarshipKnights

  class AppState
    attr_reader :app, :drawwidth, :drawheight
    def initialize(app, drawwidth, drawheight)
      @app = app
      @drawwidth = drawwidth
      @drawheight = drawheight
    end
    
    def draw
    end
    
    def update(dt)
    end
    
    def button_down(id)
    end
    
    def button_up(id)
    end
    
    def show_behind
      return false
    end
    
    def on_active
    end
  end

end