require 'zigzagaistate'
require 'whirlaaistate'

include Gosu
module StarshipKnights
  module AIStates
  
    def self.all
      out = Hash.new
      out["zigzag"] = StarshipKnights::AIStates::ZigZag
      out["whirla"] = StarshipKnights::AIStates::WhirlA
      return out
    end
  end
end