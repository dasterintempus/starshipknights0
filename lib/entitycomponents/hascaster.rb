module StarshipKnights
  module Components
    module HasCaster
      attr_reader :casterid
      attr_reader :casterspecialdrain
      
      def configure(opts)
        @casterspecialdrain = opts["casterspecialdrain"]
        super(opts)
      end
      
      def setup
        caster = nil
        @stage.get_by_shipid(@shipid).each do |e|
          if e.is_ship then
            caster = e
            break
          end
        end
        
        if caster then
          @casterid = caster.id
        else
          @stage.kill_by_id(@id)
        end
        
        super
      end
      
      def physics(dt, inputs)
        if @casterspecialdrain then
          caster = get_caster
          if caster then
            caster.drain_special(dt, @casterspecialdrain)
            if caster.curspecial <= 0.1 then
              @stage.kill_by_id(@id)
            end
          end
        end
        super(dt, inputs)
      end
      
      def get_caster
        c = @stage.get_by_id(@casterid)
        @stage.kill_by_id(@id) unless c
        return c
      end
      
      def to_s
        return "HasCaster " + super
      end
      
    end
  end
end