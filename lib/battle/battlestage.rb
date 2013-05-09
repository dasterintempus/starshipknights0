require 'battleentity'
require 'allentities'

include Gosu
module StarshipKnights

  class BattleStage  
    attr_reader :conf
    attr_reader :xsize, :ysize, :seed
    attr_reader :bg
    attr_reader :current_tick
    attr_reader :parent
    
    def initialize(parent, config=Hash.new)
      @parent = parent
      @config = config
      
      if @config.has_key? "bg" then
        bgfn = @config["bg"]
        @bgimage = Gosu::Image.new(@parent.app, bgfn, false)
      end

      @xsize = @config["xsize"] || @bgimage.width
      @ysize = @config["ysize"] || @bgimage.height
      
      @next_ent_id = 0
      @entities = Hash.new
      @current_tick = 0
      @dead = []
      @pending = []
      
      @timefactor = 1.0
      
      @prng = Random.new
    
      @inputs = Hash.new {|h,k| h[k] = InputState.new}
    end
    
    def spawn(klass, opts, teamid, shipid, x, y, angle)
      id = @next_ent_id += 1
      shipid ||= id
      @pending << [klass, opts, id, teamid, shipid, x, y, angle]
      return id
    end
    
    def roll(r)
      return @prng.rand(r)
    end
    
    def tick(dt)
      @current_tick += 1
      #$logger.debug { "Tick: " + @current_tick.to_s} if $logger
      
      cleanup
      shipinputs = Hash.new
      @entities.each_value do |e|
        next if shipinputs.has_key? e.shipid
        shipinputs[e.shipid] = @inputs[e.shipid].update
      end
      @entities.each_value do |e|
        ei = shipinputs[e.shipid]
        #$logger.debug { "eid: #{e.id} has inputs #{ei.inspect}" } if $logger
        ei ||= []
        #$logger.debug { "eid: #{e.id} has inputs #{ei.inspect}" } if $logger
        e.physics(dt*@timefactor, ei)
      end
      
      @pending.each do |p|
        factory(*p)
      end
      @pending.clear
      
      collisions
    end
    
    def draw
      @entities.each_value do |e|
        e.draw
      end
    end
    
    def get_by_id(entid)
      return @entities[entid]
    end
    
    def kill_by_id(entid)
      @dead << entid
    end
    
    def get_by_teamid(teamid)
      out = []
      @entities.each_value do |ent|
        if ent.teamid == teamid then
          out << ent
        end
      end
      return out
    end
    
    def kill_by_teamid(teamid)
      get_by_teamid(teamid).each do |e|
        kill_by_id e.id
      end
    end
    
    def get_by_shipid(shipid)
      out = []
      @entities.each_value do |ent|
        if ent.shipid == shipid then
          out << ent
        end
      end
      return out
    end
    
    def kill_by_shipid(shipid)
      get_by_shipid(shipid).each do |e|
        kill_by_id e.id
      end
    end
    
    def get_pc
      return get_by_id(@parent.pcid)
    end
    
    def get_all
      return @entities.values
    end
    
    def add_input(shipid, cmd, mode)
      #$logger.debug { "id #{id} got input #{cmd}#{mode}" } if $logger
      @inputs[shipid].handle_input InputEvent.new(cmd, mode)
    end
    
    def draw_bg
      return unless @bgimage
      scaledxdist = -@parent.camera_x * Float(@bgimage.width) / Float(@xsize)
      scaledydist = -@parent.camera_y * Float(@bgimage.height) / Float(@ysize)
      xscalefactor = Float(@xsize) / Float(@bgimage.width)
      yscalefactor = Float(@ysize) / Float(@bgimage.height)
      @bgimage.draw(scaledxdist, scaledydist, 0, xscalefactor, yscalefactor)
    end
    
    protected
    
    def factory(klass, opts, id, teamid, shipid, x, y, angle)
      fail "Bad factory klass (#{klass})" if not Entities.all.has_key? klass
      e = Entities.all[klass].new(self, id, teamid, shipid, x, y, angle)
      #e.extend(Entities.all[klass])
      #$logger.debug { e.inspect }
      e.equip(*opts["equip"]) if e.respond_to? :equip and opts.has_key? "equip"
      e.configure(opts) if e.respond_to? :configure
      e.setup if e.respond_to? :setup
      @entities[e.id] = e
      return e
    end
    
    def collisions
      @entities.each_value do |e|
        @entities.each_value do |other|
          next if other == e
          next if other.radius <= 0 or e.radius <= 0

          dx = e.x-other.x
          dy = e.y-other.y
          d = Math.sqrt(dx**2 + dy**2)
          next unless d < e.radius + other.radius
          e.collide(other) if e.respond_to? :collide

        end
      end

    end
    
    def cleanup
      @dead.uniq.each do |d|
        @entities.delete(d)
      end
      @dead.clear
      #handle wraparound
      handle_wraparound
      #deprecated, not refactored
      #handle_bounds unless @wraparound
    end
    
    def handle_wraparound
      @entities.each_value do |e|
        x = e.x
        y = e.y
        changed = false
        if x + e.radius < -0.1 then
          changed = true
          x += (@xsize + e.radius)
        elsif x - e.radius > @xsize + 0.1 then
          changed = true
          x -= (@xsize + e.radius)
        end
        if y + e.radius < -0.1 then
          changed = true
          y += (@ysize + e.radius)
        elsif y - e.radius > @ysize + 0.1 then
          changed = true
          y -= (@ysize + e.radius)
        end
        e.setpos(x,y) if changed
      end
    end
    
    def handle_bounds
      @entities.each_value do |e|
        kill = false
        if e.respond_to? :info then
          ei = e.info
          if ei[:weapon] then
            kill = true
          elsif ei[:flag] and ei[:heldby] == -1 then
            kill = true
          end
        end
        x = e.x
        xvel = e.xvel
        y = e.y
        yvel = e.yvel
        if e.x < 0.0 then
          x = 0.0001
          xvel = 0.0
        elsif e.x >= @xsize then
          x = @xsize - 0.0001
          xvel = 0.0
        end
        if e.y < 0.0 then
          y = 0.0001
          yvel = 0.0
        elsif e.y >= @ysize then
          y = @ysize - 0.0001
          yvel = 0.0
        end
        if e.x != x or e.y != y then
          if kill then
            rem_by_id(e.id)
          else
            e.setpos(x,y)
          end
        end
        e.setvel(xvel,yvel) if e.xvel != xvel or e.y != yvel
      end
    end
    
  end
  
end