require 'twinlasershot'
require 'wingshot'
require 'bomb'
require 'phoenix'
require 'rapidshot'
require 'spreadshot'
require 'kitsune'
require 'ringshot'
require 'tribeam'
require 'rocket'
require 'minotaurshield'
require 'minotaur'
require 'waveshot'
require 'disruptshot'
require 'chargeshot'
require 'wyvernshockwave'
require 'wyvern'
require 'triangleshot'
require 'torpedo'
require 'railcannon'
require 'jotunn'
require 'explosionreal'
require 'roundblockenemy'
require 'enemyrailshot'
require 'enemyrapidshot'
require 'enemytriangleshot'
require 'enemytwinlasershot'

include Gosu
module StarshipKnights
  module Entities
    def self.all
      out = Hash.new
    
      out["twinlasershot"] = StarshipKnights::Entities::TwinLaserShot
      out["wingshot"] = StarshipKnights::Entities::WingShot
      out["bomb"] = StarshipKnights::Entities::Bomb
      out["phoenix"] = StarshipKnights::Entities::Phoenix
      
      out["rapidshot"] = StarshipKnights::Entities::RapidShot
      out["spreadshot"] = StarshipKnights::Entities::SpreadShot
      out["kitsune"] = StarshipKnights::Entities::Kitsune
      
      out["ringshot"] = StarshipKnights::Entities::RingShot
      out["tribeam"] = StarshipKnights::Entities::TriBeam
      out["rocket"] = StarshipKnights::Entities::Rocket
      out["minotaurshield"] = StarshipKnights::Entities::MinotaurShield
      out["minotaur"] = StarshipKnights::Entities::Minotaur
      
      out["waveshot"] = StarshipKnights::Entities::WaveShot
      out["disruptshot"] = StarshipKnights::Entities::DisruptShot
      out["chargeshot"] = StarshipKnights::Entities::ChargeShot
      out["wyvernshockwave"] = StarshipKnights::Entities::WyvernShockwave
      out["wyvern"] = StarshipKnights::Entities::Wyvern
      
      out["triangleshot"] = StarshipKnights::Entities::TriangleShot
      out["torpedo"] = StarshipKnights::Entities::Torpedo
      out["railcannon"] = StarshipKnights::Entities::RailCannon
      out["jotunn"] = StarshipKnights::Entities::Jotunn
      
      #out["railshot"] = StarshipKnights::Entities::RailShot
      #out["slowmine"] = StarshipKnights::Entities::SlowMine
      #out["djinn"] = StarshipKnights::Entities::Djinn
      
      out["explosion"] = StarshipKnights::Entities::ExplosionReal
      #out["asteroid"] = StarshipKnights::Entities::Asteroid
    
      out.update(self.enemies)
      out["enemyrailshot"] = StarshipKnights::Entities::EnemyRailShot
      out["enemyrapidshot"] = StarshipKnights::Entities::EnemyRapidShot
      out["enemytriangleshot"] = StarshipKnights::Entities::EnemyTriangleShot
      out["enemytwinlasershot"] = StarshipKnights::Entities::EnemyTwinLaserShot
      
      return out
    end
    
    def self.enemies
      out = Hash.new
      out["roundblock"] = StarshipKnights::Entities::RoundBlockEnemy
      return out
    end
  end
end