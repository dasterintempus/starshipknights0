require 'haslifetime'
#require 'shootable'

module StarshipKnights
  module Components
    module Weapon
      include StarshipKnights::Components::HasLifetime
      #include StarshipKnights::Components::Shootable
      
      attr_reader :damage, :remaininghits, :totalhits
      
      def configure(opts)
        @damage = opts["damage"]
        @firesound = opts["firesound"]
        @totalhits = opts["totalhits"] || 1
        
        super(opts)
      end
      
      def setup
        @remaininghits = @totalhits
        super
      end
      
      def collideinfo
        return super.merge({:weapon => true, :damage => @damage})
      end
      
      def has_hits
        return @remaininghits > 0
      end
      
      def hit(other)
        #puts "Hit #{other.inspect}"
        #puts "Hits: #{@remaininghits}"
        @remaininghits-=1
        #puts "Hits: #{@remaininghits}"
        expire if @remaininghits <= 0
      end
      
      def to_s
        return "Weapon " + super
      end
      
    end
  end
end