require 'atypeaipilot'

include Gosu
module StarshipKnights
  module AIPilots
  
    def self.all
      out = Hash.new
      out["atype"] = StarshipKnights::AIPilots::AType
      return out
    end
  end
end