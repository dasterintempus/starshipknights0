require 'haslifetime'
require 'hasarmingdelay'
#require 'shootable'

module StarshipKnights
  module EntityTypes
    class Mine < StarshipKnights::BattleEntity
      include StarshipKnights::Components::HasLifetime
      include StarshipKnights::Components::HasArmingDelay
      #include StarshipKnights::Components::Shootable
      
      attr_accessor :triggersound
      
      def configure(opts)
        @triggersound = opts["triggersound"]
        opts["lifetimer"] ||= -0.15
        super(opts)
      end
      
      def setup
        @triggered = false
        if @plantsound then
          play_sound(@plantsound, @x, @y)
        end
        super
      end
      
      def collide(other)
        if @armed then
          if other.teamid != @teamid then
            oci = other.collideinfo
            if not oci[:weapon]
              if @triggersound then
                play_sound(@triggersound, @x, @y)
              end
              trigger(other)
              @armed = false
              @imagename += "_trigger"
              rebuild_image
              @triggered = true
              @pauselifetimer = false
              return
            end
          end
        end
        super(other)
      end

      def collideinfo
        return super.merge({:weapon => true, :mine => true})
      end
      
      def drawinfo
        return super.merge({:invis => @armed})
      end
      
    end
  end
end