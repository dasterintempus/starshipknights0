require 'appstate'

include Gosu
module StarshipKnights

  class AppMenuState < AppState
    def initialize(app, drawwidth, drawheight, options, title=nil)
      super(app, drawwidth, drawheight)
      if title then
        if title.respond_to? :draw then
          @title = title
        else
          @title = Gosu::Image.from_text(@app, title.to_s, "Arial", 32, 5, 200, :left)
        end
      end
      @options = []
      @fields = []
      options.each do |o|
        if o[0] == "_" then
          o.slice!(0)
          @fields << o
        else
          @fields << ""
        end
        @options << o
      end
      @field_text = {}
      @field_imgs = []
      @entry_field = -1
      @sel_opt = 0
      @opt_imgs = []
      @options.each do |opt|
        @opt_imgs << Gosu::Image.from_text(@app, opt, "Arial", 22, 5, 200, :left)
      end
      @cursor_img = Gosu::Image.new(@app, "./gfx/menu_cursor.png", false)
    end
  
    def update_field_text
      @field_imgs = []
      @fields.each do |field|
        @field_imgs << Gosu::Image.from_text(@app, @field_text[field], "Arial", 14, 2, 150, :left)
      end
    end
    
    def draw
      @app.text_input.draw if @app.text_input
    
      if @title then
        @title.draw(@drawwidth/3.0, (@drawheight/(@opt_imgs.length+2)), 50)
      end
      n = 1
      @opt_imgs.each do |optimg|
        if @title then
          y = (@drawheight/(@opt_imgs.length+2)) * (n+1)
        else
          y = (@drawheight/(@opt_imgs.length+1)) * (n)
        end
        c = Gosu::Color::WHITE
        c = self.option_color(n-1) if self.respond_to? :option_color
        optimg.draw(@drawwidth/3.0, y, 10, 1.0, 1.0, c)
        if @sel_opt + 1 == n then
          @cursor_img.draw(@drawwidth/4.0, y, 35) if @entry_field == -1
        end
        if @fields[n-1] != "" and @entry_field != n-1 then
          if @title then
            y = ((@drawheight/(@opt_imgs.length+2)) * (n+1)) + @opt_imgs[n-1].height
          else
            y = ((@drawheight/(@opt_imgs.length+1)) * n) + @opt_imgs[n-1].height
          end
          @field_imgs[n-1].draw(@drawwidth/3.0, y, 28)
        end
        n += 1
      end
    end
    
    def button_down(id)
      if @entry_field != -1 then
        if id == Gosu::KbEscape then
          #cancel entry
          @entry_field = -1
          @app.text_input = nil
        elsif id == Gosu::KbReturn then
          @field_text[@fields[@entry_field]] = @app.text_input.text
          @entry_field = -1
          @app.text_input = nil
          update_field_text
        end
      else
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
          when Gosu::KbS
            arrow_down
          when Gosu::KbW
            arrow_up
          when Gosu::KbReturn
            @app.play_sound("menuok")
            select_option
          when Gosu::KbSpace
            @app.play_sound("menuok")
            select_option
          when Gosu::KbNumpad1
            @app.play_sound("menuok")
            select_option
        end
      end
    end
    
    def arrow_down
      @sel_opt += 1
      if @sel_opt > @options.length-1 then
        @sel_opt = @options.length-1
        @app.play_sound("menufail")
      else
        @app.play_sound("menublip")
      end
    end
    
    def arrow_up
      @sel_opt -= 1
      if @sel_opt < 0 then
        @sel_opt = 0 
        @app.play_sound("menufail")
      else
        @app.play_sound("menublip")
      end
    end
  end

end