require 'appstate'

include Gosu
module StarshipKnights

  class GameAppState < AppState
    def initialize(app, drawwidth, drawheight)
      super(app, drawwidth, drawheight)
    end
    
    def on_active
      if $game.lastbattlestatus >= 0 then
        start_next_stage
      else
        @app.pop_state
      end
    end
    
    def start_next_stage
      #temporary hack
      conf = nil
      waves = nil
      File.open("./stages/teststage.conf", "r") do |f|
        data = JSON.load(f)
        waves = data["waves"]
        conf = data["conf"]
      end
      
      @app.add_state BattleStageAppState.new(@app, @drawwidth, @drawheight, waves, conf)
      @app.add_state LevelChangeAppState.new(@app, @drawwidth, @drawheight, $game.currentlevel)
    end
  end
  
end