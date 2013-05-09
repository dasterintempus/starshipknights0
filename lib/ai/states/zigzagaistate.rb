require 'battleaistate'

include Gosu
module StarshipKnights
  module AIStates
    class ZigZag < BattleAIState
      def initialize(parent)
        super(parent)
        add_pattern("zigzag", true)
        add_pattern("inputalways", ["thrust"])
      end
    end
  end
end