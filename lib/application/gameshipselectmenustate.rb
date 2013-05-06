require 'appmenustate'
require 'gamediffselectmenustate'

include Gosu
module StarshipKnights

  class GameShipSelectMenuState < AppMenuState
    
    def initialize(app, drawwidth, drawheight)
      @shipoptions = ["Phoenix", "Kitsune", "Minotaur", "Wyvern", "Jotunn"]
      super(app, drawwidth, drawheight, @shipoptions)
    end
  
    def select_option
      $game.selectship(@shipoptions[@sel_opt].downcase)
      @app.pop_state
      @app.add_state GameDiffSelectMenuState.new(@app, @drawwidth, @drawheight)
    end
  end
  
end