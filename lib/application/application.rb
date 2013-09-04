require 'mainmenustate'

include Gosu
module StarshipKnights

  class Application < Gosu::Window
    attr_reader :win_x, :win_y
    
    def self.config_file_path
      return "./app.cfg"
    end
    
    def initialize()
      @win_x = $config["xres"] || 800
      @win_y = $config["yres"] || 600
      @fullscreen = $config["fullscreen"] == 1 || false
      
      super(@win_x, @win_y, @fullscreen)
      self.caption = "StarshipKnights"
      
      @last_time = Time.now.to_f
      @states = []
      
      @samples = Hash.new
      Dir.glob("./sfx/*.wav").each do |filename|
        #puts filename
        name = File.basename(filename, ".wav")
        #puts name
        @samples[name] = Gosu::Sample.new(self, filename)
      end
      @images = Hash.new
      Dir.glob("./gfx/*.png").each do |filename|
        #puts filename
        name = File.basename(filename, ".png")
        #puts name
        @images[name] = Gosu::Image.new(self, filename, false)
      end
      @songs = Hash.new
      Dir.glob("./bgm/*.ogg").each do |filename|
        name = File.basename(filename, ".ogg")
        @songs[name] = Gosu::Song.new(self, filename)
      end
      
      add_state MainMenuState.new(self, @win_x, @win_y)
    end
    
    def play_sound(name, pan = nil, vol = nil)
      if pan != nil and vol != nil then
        @samples[name].play_pan(pan, vol)
      else
        @samples[name].play
      end
    end
    
    def play_music(name, looping=false)
      @songs[name].play(looping)
    end
    
    def stop_music
      Gosu::Song.current_song.stop if Gosu::Song.current_song
    end
    
    def get_image(name)
      return @images[name]
    end
    
    def draw_rect(x,y,w,h,c,z)
      x1 = x
      y1 = y
      x2 = x+w
      y2 = y
      x3 = x+w
      y3 = y+h
      x4 = x
      y4 = y+h
      draw_quad(x1,y1,c,x2,y2,c,x3,y3,c,x4,y4,c,z)
    end
    
    def pop_state
      @states.delete_at(-1)
      active_state.on_active if @states.count > 0
    end
    
    def add_state(s)
      @states << s
      active_state.on_active
    end
    
    def active_state
      return @states[-1]
    end
    
    def update
      dt = Time.now.to_f - @last_time
      @last_time = Time.now.to_f
      
      #@respawn_wait -= dt if @respawn_wait and @respawn_wait > 0.0
      
      @states.reverse_each do |state|
        ret = state.update(dt)
        break unless ret and ret == -1
      end
      if @states.length == 0 then
        close
      end
    end
    
    def draw
      @states.reverse_each do |state|
        done = false
        clip_to(0,0,state.drawwidth,state.drawheight) do
          state.draw
          done = true unless state.show_behind
          #puts "done: #{done}"
        end
        break if done
      end
    end
    
    def button_down(id)
      @states.reverse_each do |state|
        ret = state.button_down(id)
        break unless ret and ret == -1
      end
    end
    
    def button_up(id)
      @states.reverse_each do |state|
        ret = state.button_up(id)
        break unless ret and ret == -1
      end
    end
  
  end

end