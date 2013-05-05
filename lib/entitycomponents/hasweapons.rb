module StarshipKnights
  module Components
    module HasWeapons
      attr_reader :priweptypename, :priwepcooldown
      attr_reader :secweptypename, :secwepcooldown
      attr_accessor :priwepchargetime, :secwepchargetime
      
      def configure(opts)
        @priweptypename = opts["priweptypename"]
        @secweptypename = opts["secweptypename"]
        super(opts)
      end
      
      def setup
        @priwepcooldown = 0.0
        @secwepcooldown = 0.0
        @priwepchargetime = 0.0 if get_priwep.shootingproperties[:charging]
        @secwepchargetime = 0.0 if @secweptypename and get_secwep.shootingproperties[:charging]
        super
      end
      
      def physics(dt, inputs)
        @priwepcooldown -= dt if @priwepcooldown > 0
        @secwepcooldown -= dt if @secweptypename and @secwepcooldown > 0
        
        pricharging = false
        seccharging = false
        inputs.each do |input|
          case input.cmd
            when "fire"
              if get_priwep.shootingproperties[:charging] then
                pri_charge(dt)
                pricharging = true
              else
                pri_fire
              end
            when "altfire"
              if @secweptypename then
                if get_secwep.shootingproperties[:charging] then
                  sec_charge(dt)
                  seccharging = true
                else
                  sec_fire
                end
              end
          end
        end
        
        #really fire charging weapons
        pri_fire if get_priwep.shootingproperties[:charging] and @priwepchargetime > 0.0 and not pricharging
        sec_fire if @secweptypename and get_secwep.shootingproperties[:charging] and @secwepchargetime > 0.0 and not seccharging
        
        super(dt, inputs)
      end
      
      def pri_charge(dt)
        @priwepchargetime += dt
        @priwepchargetime = Util.clamp(@priwepchargetime, 0, get_priwep.shootingproperties[:charging])
        if get_priwep.chargesound then
          @chargesoundreplaytime -= dt
          if @chargesoundreplaytime <= 0.0 then
            @chargesoundreplaytime = 0.35
            play_sound(get_priwep.chargesound, @x, @y)
          end
        end
      end
      
      def sec_charge(dt)
        @secwepchargetime += dt
        @secwepchargetime = Util.clamp(@secwepchargetime, 0, get_secwep.shootingproperties[:charging])
        if get_secwep.chargesound then
          @chargesoundreplaytime -= dt
          if @chargesoundreplaytime <= 0.0 then
            @chargesoundreplaytime = 0.35
            play_sound(get_secwep.chargesound, @x, @y)
          end
        end
      end
      
      def pri_fire(opts=Hash.new)
        return if not @priweptypename
        #check cooldown
        return if @priwepcooldown > 0.0
        @priwepcooldown = priwepcooldowntimer
        shoot(get_priwep, @priweptypename, "pri")
        #make ent
        #x = @x + Math.cos(Util.rad(@angle)) * 10.0
        #y = @y + Math.sin(Util.rad(@angle)) * 10.0
        #TODO new spawn system goes here
        #@stage.spawn(@priweptypename, opts, @teamid, @id, x, y, @angle)
      end
      
      def sec_fire(opts=Hash.new)
        return if not @secweptypename
        #check cooldown
        return if @secwepcooldown > 0.0
        @secwepcooldown = secwepcooldowntimer
        shoot(get_secwep, @secweptypename, "sec")
        #make ent
        #x = @x + Math.cos(Util.rad(@angle)) * 10.0
        #y = @y + Math.sin(Util.rad(@angle)) * 10.0
        #opts = Hash.new
        #TODO new spawn system goes here
        #@stage.spawn(@secweptypename, opts, @teamid, @id, x, y, @angle)
      end
      
      def weaponcooldown(slot, time)
        if slot == "pri" then
          @priwepcooldown = time
        elsif slot == "sec" then
          @secwepcooldown = time
        end
      end
      
      def priwepcooldowntimer
        return get_priwep.shootingproperties[:cooldown]
      end
      
      def secwepcooldowntimer
        return get_secwep.shootingproperties[:cooldown]
      end
      
      def get_priwep
        return StarshipKnights::Entities.all[@priweptypename]
      end
      
      def get_secwep
        return StarshipKnights::Entities.all[@secweptypename]
      end
      
      def shoot(wep, wepname, slot)
        opts = Hash.new
        
        if wep.shootingproperties[:charging] then
          if slot == "pri" then
            opts["chargetime"] = @priwepchargetime
            @priwepchargetime = 0.0
          elsif slot == "sec" then
            opts["chargetime"] = @secwepchargetime
            @secwepchargetime = 0.0
          end
        end
        
        if wep.shootingproperties[:firingangles] then
          wep.shootingproperties[:firingangles].each do |firingangle|
            realangle = @angle + firingangle
            x = @x + Math.cos(Util.rad(realangle)) * 10.0
            y = @y + Math.sin(Util.rad(realangle)) * 10.0
            @stage.spawn(wepname, opts, @teamid, @id, x, y, realangle)
          end
        else
          x = @x + Math.cos(Util.rad(@angle)) * 10.0
          y = @y + Math.sin(Util.rad(@angle)) * 10.0
          @stage.spawn(wepname, opts, @teamid, @id, x, y, @angle)
        end
        
        if wep.firesound then
          play_sound(wep.firesound, @x, @y)
        end
        
      end
      
      def to_s
        return "HasWeapons " + super
      end
    end
  end
end
