require 'battleaipattern'

include Gosu
module StarshipKnights
  module AIPatterns
    class InputAlways < BattleAIPattern
      def initialize(parent, inputs)
        super(parent)
        @inputs = inputs
      end
      
      def setup
        @inputs.each do |input|
          add_input(input, "+")
        end
        super
      end
      
      def teardown
        @inputs.each do |input|
          add_input(input, "-")
        end
        super
      end
      
    end
    
  end
 
end