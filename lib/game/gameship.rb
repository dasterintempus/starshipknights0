include Gosu
module StarshipKnights

  class GameShip
    
    attr_reader :klass
    attr_accessor :equip
    def initialize(klass)
      @klass = klass
      @equip = Loadout.__send__("#{klass.downcase}_equip_default")
      @equip[0] = "TriBeam"
    end
    
    def spawn(battlestage, x, y, angle, opts=nil)
      opts ||= Hash.new
      opts["equip"] = @equip
      return battlestage.spawn(klass, opts, 0, nil, x, y, angle)
    end
  end

end