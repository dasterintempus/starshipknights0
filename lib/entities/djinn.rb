require 'ship'

module StarshipKnights
  module Entities
    class Djinn < StarshipKnights::EntityTypes::Ship
    
      attr_reader :max_mine_count
      def configure(opts)
        if @teamid == 0 then
          opts["imagename"] ||= "djinnred"
        elsif @teamid == 1 then
          opts["imagename"] ||= "djinnblue"
        end
        opts["priweptypename"] ||= "railshot"
        #CD 1.25
        opts["secweptypename"] ||= "slowmine"
        #CD 5.0
        
        opts["turnspeed"] ||= 200.0
        opts["thrustspeed"] ||= 195.0
        opts["maxspeed"] ||= 235.0
        
        opts["maxhealth"] ||= 12.5
        
        opts["maxspecial"] ||= 5.0
        
        @max_mine_count = opts["max_mine_count"] || 5
        super(opts)
      end
      
      def setup
        @stealth = false
        @invis = false
        super
      end
      
      def drawinfo
        return super.merge({:stealth => @stealth, :invis => @invis})
      end
      
      def physics(dt, inputs)
        @stealth = false
        @invis = false
        #look for slide
        inputs.each do |input|
          case input.cmd
            when "special"
              if @curspecial > 0.1 then
                if @equippedspecial == "cloak" then
                  @invis = true
                  drain_special(dt, 2.5)
                elsif @equippedspecial == "stealth"
                  @stealth = true
                  drain_special(dt, 1.0)
                end
              end
          end
        end #not sliding
        
        recharge_special(dt) unless @invis or @stealth
        
        super(dt, inputs)
      end
      
      def sec_fire
        return if count_mines >= @max_mine_count
        super
      end
      
      def count_mines
        count = 0
        @stage.get_by_shipid(@shipid).each do |e|
          eci = e.collideinfo
          count += 1 if eci[:mine]
        end
        return count
      end
      
      def to_s
        return "Djinn " + super
      end
      
    end
  end
end