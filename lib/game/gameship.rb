include Gosu
module StarshipKnights

  class GameShip
    
    attr_reader :klass
    attr_accessor :equipment
    def initialize(klass)
      @klass = klass
      @equipment = Loadout.__send__("#{klass.downcase}_equip_default")
    end
    
    def equip(equipment)
      @equipment = equipment if Loadout.validate(@klass, equipment)
    end
    
    def spawn(battlestage, x, y, angle, opts=nil)
      return nil unless Loadout.validate(@klass, @equipment)
      opts ||= Hash.new
      opts["equip"] = @equipment
      return battlestage.spawn(klass, opts, 0, nil, x, y, angle)
    end
  end

end