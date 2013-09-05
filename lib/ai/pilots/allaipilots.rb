require 'cyanroundblockai'
require 'yellowroundblockai'
require 'fuschiaroundblockai'
require 'cyanrayai'

include Gosu
module StarshipKnights
  module AIPilots
  
    def self.all
      out = Hash.new
      out["roundblock"] = {}
      out["roundblock"]["cyan"] = StarshipKnights::AIPilots::CyanRoundBlock
      out["roundblock"]["yellow"] = StarshipKnights::AIPilots::YellowRoundBlock
      out["roundblock"]["fuschia"] = StarshipKnights::AIPilots::FuschiaRoundBlock
      out["ray"] = {}
      out["ray"]["cyan"] = StarshipKnights::AIPilots::CyanRay
      return out
    end
  end
end