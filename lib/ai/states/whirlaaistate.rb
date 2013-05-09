require 'battleaistate'

include Gosu
module StarshipKnights
  module AIStates
    class WhirlA < BattleAIState
      def initialize(parent)
        super(parent)
        add_pattern("zigzag")
        add_pattern("inputalways", ["thrust"])
      end
    end
  end
end