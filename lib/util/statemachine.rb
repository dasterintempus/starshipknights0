include Gosu
module StarshipKnights
  module StateMachine
    def init_statemachine
      @sm_states = Hash.new
      @sm_statename = ""
    end
    
    def current_state
      return @sm_states[@sm_statename]
    end
    
    def change_state(statename)
      current_state.on_leave if current_state and current_state.respond_to? :on_leave
      @sm_statename = statename
      current_state.on_enter if current_state and current_state.respond_to? :on_enter
    end
  end

end