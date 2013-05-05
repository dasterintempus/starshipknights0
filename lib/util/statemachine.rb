include Gosu
module StarshipKnights

  module StateMachine
    
    def init_statemachine
      @last_time = Time.now.to_f
      @states = []
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
      done = false
      @states.reverse_each do |state|
        clip_to(0,0,state.drawwidth,state.drawheight) do
          state.draw
          done = true unless state.show_behind
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