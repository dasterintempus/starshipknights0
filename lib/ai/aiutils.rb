require 'util'

include Gosu
module StarshipKnights
  module AIUtils
    def self.find_player_ship(battlestage)
      battlestage.get_by_teamid(0).each do |e|
        return e if e.is_ship
      end
      return nil
    end
    
    def self.is_aimed_at(aimer, target, fuzz=3.5)
      angle = Util.angle(aimer.x, aimer.y, target.x, target.y)
      return (angle - aimer.angle).abs <= fuzz
    end
  end
end