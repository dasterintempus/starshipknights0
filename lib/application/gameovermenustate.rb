require 'appmenustate'

include Gosu
module StarshipKnights

  class GameOverMenuState < AppMenuState
    
    def initialize(app, drawwidth, drawheight)
      @options = ["Game Over", "Retry"]
      super(app, drawwidth, drawheight, @options)
    end
  
    def select_option
      @app.pop_state
      if @sel_opt == 1 then
        $game.resetbattle
        @app.add_state GameAppState.new(@app, @drawwidth, @drawheight)
      end
    end
  end
  
end