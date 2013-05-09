require 'zigzagaipattern'
require 'inputalwaysaipattern'

include Gosu
module StarshipKnights
  module AIPatterns
  
    def self.all
      out = Hash.new
      out["zigzag"] = StarshipKnights::AIPatterns::ZigZag
      out["inputalways"] = StarshipKnights::AIPatterns::InputAlways
      return out
    end
  end
end