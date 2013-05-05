require 'missile'

module StarshipKnights
  module Entities
    class Torpedo < StarshipKnights::EntityTypes::Missile
      def self.shootingproperties
        return super.merge({:cooldown => 2.5})
      end
      
      def self.firesound
        return "missilelaunchalt"
      end
      
      def configure(opts)
        opts["radius"] ||= 6.0
        if @teamid == 0 then
          opts["imagename"] ||= "torpedored"
        elsif @teamid == 1 then
          opts["imagename"] ||= "torpedoblue"
        end
        opts["blastsound"] ||= "missileblast"
        opts["lifetimer"] ||= 2.0
        opts["damage"] ||= 4.0
        opts["blastsize"] ||= 70.0
        opts["thrustspeed"] ||= 185.0
        opts["maxspeed"] ||= 550.0
        super(opts)
      end

      def physics(dt, inputs)
        inputs.each do |input|
          case input.cmd
            when "altfire"
              if @lifetime <= 1.5 then
                detonate
              end
          end
        end
        
        super(dt, inputs)
      end
      
      def to_s
        return "Torpedo " + super
      end
    end
  end
end