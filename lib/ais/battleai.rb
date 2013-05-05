include Gosu
module StarshipKnights
  class BattleAI
      attr_accessor :id, :battlestage
      
      def initialize(id, battlestage)
        @id = id
        @battlestage = battlestage
      end
      
      def add_input(cmd, mode="")
        @battlestage.add_input(@id, cmd, mode)
      end
      
      def configure(opts)
      end
      
      def setup
      end
      
      def think(dt)
      end
    end

  module AIPatterns
    def self.all
      out = Hash.new
      out["zigzag"] = StarshipKnights::AIPatterns::ZigZag
      out["forwardback"] = StarshipKnights::AIPatterns::ForwardBack
      out["inputalways"] = StarshipKnights::AIPatterns::InputAlways
      return out
    end
  end
  
end