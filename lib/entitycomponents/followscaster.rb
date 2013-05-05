require 'hascaster'

module StarshipKnights
  module Components
    module FollowsCaster
      include StarshipKnights::Components::HasCaster
      
      def physics(dt, inputs)
        caster = get_caster
        if caster then
          @x = caster.x
          @y = caster.y
        end
        super(dt, inputs)
      end
    
    end
  end
end