require 'appstate'

include Gosu
module StarshipKnights

  class GameMapAppState < AppState
    
    def initialize(app, drawwidth, drawheight)
      super(app, drawwidth, drawheight)
      @starimages = Hash.new { |h,k| h[k] = @app.get_image(k+"star") }
      @app.play_music("starmap", true)
      @cursorcoords = Array.new $game.playerstarcoords
      @cursorimage = @app.get_image("starcursor")
    end
    
    def update(dt)
    end
    
    def draw
      draw_starmap
      draw_player
      draw_cursor
    end
    
    def button_down(id)
      if [Gosu::KbLeft, Gosu::KbA].include? id then
        adjust_cursor(-1, 0)
      elsif [Gosu::KbRight, Gosu::KbD].include? id then
        adjust_cursor(1, 0)
      elsif [Gosu::KbUp, Gosu::KbW].include? id then
        adjust_cursor(0, -1)
      elsif [Gosu::KbDown, Gosu::KbS].include? id then
        adjust_cursor(0, 1)
      end
      
    end
    
    def button_up(id)
    end
    
    protected
    
    def adjust_cursor(dx, dy)
      @app.play_sound("menublip")
      @cursorcoords[0] += dx
      @cursorcoords[1] += dy
      @cursorcoords[0] = Util.clamp(@cursorcoords[0], 0, $game.starmap.width-1)
      @cursorcoords[1] = Util.clamp(@cursorcoords[1], 0, $game.starmap.height-1)
    end
    
    def draw_starmap
      starmap = $game.starmap
      cellwidth = drawwidth / starmap.width
      cellheight = drawheight / starmap.height
      starmap.stars.each do |coords, star|
        @starimages[star.color].draw(cellwidth * coords[0], cellheight * coords[1], 0)
      end
    end
    
    def draw_player
      starcoords = $game.playerstarcoords
      cellwidth = drawwidth / $game.starmap.width
      cellheight = drawheight / $game.starmap.height
      shipx = cellwidth * starcoords[0]
      shipy = cellheight * starcoords[1]
      cursorx = (cellwidth * @cursorcoords[0]) + cellwidth/2
      cursory = (cellheight * @cursorcoords[1]) + cellheight/2
      angle = Util.angle(shipx, shipy, cursorx, cursory)
      shipimage = @app.get_image($game.playeractiveship.klass+"red")
      shipimage.draw_rot(shipx, shipy, 2, angle, 0.5, 0.5)
    end
  
    def draw_cursor
      cellwidth = drawwidth / $game.starmap.width
      cellheight = drawheight / $game.starmap.height
      cursorx = cellwidth * @cursorcoords[0]
      cursory = cellheight * @cursorcoords[1]
      @cursorimage.draw(cursorx, cursory, 3)
    end
  end

end
