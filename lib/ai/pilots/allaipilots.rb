require 'simpleaipilot'

include Gosu
module StarshipKnights
  module AIPilots
  
    def self.all
      out = Hash.new
      out["simple"] = StarshipKnights::AIPilots::Simple
      return out
    end
  end
end