require 'appmenustate'
require 'battlestageappstate'
require 'gameshipselectmenustate'

include Gosu
module StarshipKnights

  class MainMenuState < AppMenuState
  
    def initialize(app, drawwidth, drawheight)
      options = ["Play", "Quit"]
      super(app, drawwidth, drawheight, options)
      @logo = Gosu::Image.new(app, "./gfx/logo.png", true)
    end
    
    def draw
      super
      @logo.draw(250, 10, 30)
    end
    
    def select_option
      case @sel_opt
        when 0
          $game = Game.new
          @app.add_state GameShipSelectMenuState.new(@app, @drawwidth, @drawheight)
        #when 1
        #  $game = Game.new
        #  conf = nil
        #  enemies = nil
        #  File.open("./stages/teststage.conf", "r") do |f|
        #    data = JSON.load(f)
        #    enemies = data["enemies"]
        #    conf = data["conf"]
        #  end
        #  @app.add_state BattleStageAppState.new(@app, @drawwidth, @drawheight, enemies, conf)
        #when 2
        #  #@app.add_state OptionMenuAppState.new(@app, @drawwidth, @drawheight)
        else
          @app.pop_state
      end
    end
    
  end

end