require 'appmenustate'

include Gosu
module StarshipKnights

  class GameDiffSelectMenuState < AppMenuState
    
    def initialize(app, drawwidth, drawheight)
      @diffoptions = ["Easy", "Medium", "Hard", "WTF"]
      super(app, drawwidth, drawheight, @diffoptions, "Select Difficulty")
    end
  
    def select_option
      $game.difficulty = @sel_opt + 1
      @app.pop_state
      @app.add_state GameAppState.new(@app, @drawwidth, @drawheight)
    end
  end
  
end