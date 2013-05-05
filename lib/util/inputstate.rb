module StarshipKnights

  class InputState
    def initialize()
      @persistent_inputs = Array.new
      @fleeting_inputs = Array.new
    end
    
    def update
      out = @persistent_inputs | @fleeting_inputs
      #$servlogger.debug { "input state (update): " + out.inspect} if $servlogger
      @fleeting_inputs.clear
      return out
    end
    
    def has_pers_input?(cmd)
      @persistent_inputs.each do |i|
        return true if i.cmd == cmd
      end
      return false
    end
    
    def handle_input(input)
      #puts "Handling input in inputstate"
      #puts input.cmd, input.opt
      case input.mode
        when "+"
          @persistent_inputs << input if not has_pers_input? input.cmd
        when "-"
          @persistent_inputs.delete_if {|i| i.cmd == input.cmd}
        when nil
          @fleeting_inputs << input
        when ""
          @fleeting_inputs << input
      end
    end
  end

end