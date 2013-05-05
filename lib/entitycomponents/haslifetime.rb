module StarshipKnights
  module Components
    module HasLifetime
      attr_reader :lifetimer, :lifetime
      def configure(opts)
        @lifetimer = opts["lifetimer"]
        super(opts)
      end
      
      def setup
        @pauselifetimer = true if @lifetimer < 0
        @pauselifetimer ||= false
        @lifetimer = @lifetimer.abs
        @lifetime = @lifetimer
        super
      end
    
      def physics(dt, inputs)
        @lifetime -= dt if @lifetime > 0.0 and not @pauselifetimer
        if @lifetime <= 0.0 then
          expire
        end
        super(dt, inputs)
      end
      
      def expire
        @stage.kill_by_id(@id)
      end
      
      def to_s
        return "HasLifetime " + super
      end
      
    end
  end
end