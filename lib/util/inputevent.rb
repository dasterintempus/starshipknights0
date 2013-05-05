module StarshipKnights

  class InputEvent
    include Comparable
    
    attr_reader :cmd, :mode, :params
    
    #@@input_priority = ["ANNOUNCE", "DISCONNECT", "CONNECT", "VERSION", "YOUARE", "NAME", "CHECKSUM", "WORLD", "START", "STATE", "READY", "SPECTATE", "SIGNOFF"]
    #@@input_state_priority = ["ready", "playing"]
    @@priorities = ["aim", "fire", "altfire", "special", "thrust", "rthrust", "left", "right"]
    
    def initialize(cmd, mode)
      @cmd = cmd
      @mode = mode
    end
    
    def method_missing(symbol, args = [])
      return @params[symbol.to_s]
    end
    
    def to_s
      return "INPUT: #{@cmd}#{@mode}"
    end
    
    def sort_priority
      return @@priorities.index(@cmd)
    end
    
    def mode_priority
      case mode
        when "+"
          return -1
        when "-"
          return 1
        else
          return 0
      end
    end
    
    def <=>(other)
      return [@turn, sort_priority, mode_priority, to_s] <=> [other.turn, other.sort_priority, other.mode_priority, other.to_s]
    end
  end

end