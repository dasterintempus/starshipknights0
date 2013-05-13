require 'atypeaipilot'
require 'btypeaipilot'
require 'ctypeaipilot'

include Gosu
module StarshipKnights
  module AIPilots
  
    def self.all
      out = Hash.new
      out["atype"] = StarshipKnights::AIPilots::AType
      out["btype"] = StarshipKnights::AIPilots::BType
      out["ctype"] = StarshipKnights::AIPilots::CType
      return out
    end
  end
end