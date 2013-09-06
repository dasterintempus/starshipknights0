require 'battleentity'

require 'thruster'
require 'hasweapons'
require 'hashealth'
require 'hasspecialgauge'
require 'takesdamagecollisions'
require 'takesknockback'
require 'equippable'

module StarshipKnights
  module EntityTypes
    class Ship < StarshipKnights::BattleEntity
      include StarshipKnights::Components::Thruster
      include StarshipKnights::Components::HasHealth
      include StarshipKnights::Components::HasWeapons
      include StarshipKnights::Components::HasSpecialGauge
      include StarshipKnights::Components::TakesDamageCollisions
      include StarshipKnights::Components::TakesKnockback
      include StarshipKnights::Components::Equippable
      
      def configure(opts)
        opts["radius"] ||= 10.0
        opts["hitsound"] ||= "hit"
        opts["diesound"] ||= "shipdie"
        @brakespeed = opts["brakespeed"] ||= 1.25

        super(opts)
      end
      
      def physics(dt, inputs)
        inputs.each do |input|
          case input.cmd
          when "brake"
            applybrake(dt)
          end
        end
        super(dt, inputs)
      end
      
      def to_s
        return "Ship " + super
      end
      
      protected
      
      def applybrake(dt)
        dx = @xvel * @brakespeed * dt
        dy = @yvel * @brakespeed * dt
        accel(-dx, -dy)
      end
      
    end
  end
end
