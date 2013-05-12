require 'atypeaipilot'
require 'btypeaipilot'

include Gosu
module StarshipKnights
  module AIPilots
  
    def self.all
      out = Hash.new
      out["atype"] = StarshipKnights::AIPilots::AType
      out["btype"] = StarshipKnights::AIPilots::BType
      return out
    end
  end
end