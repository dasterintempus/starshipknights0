require 'shockwave'

module StarshipKnights
  module Entities
    class WyvernShockwave < StarshipKnights::EntityTypes::Shockwave
    
      def configure(opts)
        opts["firesound"] ||= "shockwave"
        opts["hits"] ||= 5
        super(opts)
      end
      
      def to_s
        return "WyvernShockwave " + super
      end
      
    end
  end
end