module StarshipKnights

  module Loadout
    def self.ship_names
      return ["Phoenix", "Minotaur", "Kitsune", "Wyvern", "Jotunn"]#, "Djinn"]
    end
    
    def self.phoenix_loadout
      return {"Primary" => ["TwinLaserShot"],
              "Secondary" => ["WingShot", "Bomb"],
              "Special" => ["Afterburner"]}
    end
    
    def self.minotaur_loadout
      return {"Primary" => ["RingShot", "TriBeam"],
              "Secondary" => ["Rocket"],
              "Special" => ["ShieldBubble"]}
    end
    
    def self.kitsune_loadout
      return {"Primary" => ["RapidShot"],
              "Secondary" => ["SpreadShot"],
              "Special" => ["Slide", "ReverseMomentum"]}
    end
    
    def self.wyvern_loadout
      return {"Primary" => ["WaveShot", "DisruptShot"],
              "Secondary" => ["ChargeShot"],
              "Special" => ["Shockwave"]}
    end
    
    def self.jotunn_loadout
      return {"Primary" => ["TriangleShot", "RailCannon"],
              "Secondary" => ["Torpedo"],
              "Special" => ["TurretMode"]}
    end
    
    #def self.djinn_loadout
    #  return {"Primary" => ["RailShot"],
    #          "Secondary" => ["SlowMine"],
    #          "Special" => ["Stealth", "Cloak"]}
    #end
    
    def self.phoenix_equip_default
      return ["TwinLaserShot", "WingShot", "Afterburner"]
    end
    
    def self.minotaur_equip_default
      return ["RingShot", "Rocket", "ShieldBubble"]
    end
    
    def self.kitsune_equip_default
      return ["RapidShot", "SpreadShot", "Slide"]
    end
    
    def self.wyvern_equip_default
      return ["WaveShot", "ChargeShot", "Shockwave"]
    end
    
    def self.jotunn_equip_default
      return ["TriangleShot", "Torpedo", "TurretMode"]
    end
    
    #def self.djinn_equip_default
    #  return ["RailShot", "SlowMine", "Stealth"]
    #end
    
    def self.validate(klass, equip)
      return false unless self.ship_names.include? klass.capitalize
      allowed = self.__send__("#{klass.downcase}_loadout")
      n = 0
      allowed.each do |slot, opts|
        return false unless opts.include? equip[n]
        n += 1
      end
      return true
    end
  end

end