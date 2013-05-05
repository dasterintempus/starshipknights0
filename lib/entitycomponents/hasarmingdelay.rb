module StarshipKnights
  module Components
    module HasArmingDelay
      attr_reader :armingtimer, :armingtime
      
      def configure(opts)
        @armingtimer = opts["armingtimer"]
        super(opts)
      end
      
      def setup
        @armingtime = @armingtimer
        @armed = false
      end
      
      def physics(dt, inputs)
        if @armingtime > 0.0 then
          @armed = false
          @armingtime -= dt
          if @armingtime <= 0.0 then
            @armed = true
            armingcomplete if self.respond_to? :armingcomplete
          end
        end
        
        super(dt, inputs)
      end
    end
  end
end