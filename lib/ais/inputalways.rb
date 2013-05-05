include Gosu
module StarshipKnights
  module AIPatterns
    module InputAlways
      def configure(opts)
        @alwaysinputs = opts["alwaysinputs"]
        super
      end
      def setup
        @alwaysinputs.each do |input|
          add_input(input, "+")
        end
        super
      end
      
    end
    
  end
 
end