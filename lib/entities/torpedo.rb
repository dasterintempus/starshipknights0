require 'missile'

module StarshipKnights
  module Entities
    class Torpedo < StarshipKnights::EntityTypes::Missile
      class << self
        attr_accessor :shootingproperties, :firesound
      end
      @shootingproperties = {:cooldown => 2.5}
      @firesound = "missilelaunchalt"
      
      def configure(opts)
        opts["radius"] ||= 6.0
        opts["imagename"] ||= "torpedo"
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
              if @lifetime <= 0.75 then
                expire
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