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
require 'centaurshield'
require 'centaur'
require 'waveshot'
require 'disruptshot'
require 'chargeshot'
require 'wyvernshockwave'
require 'wyvern'
require 'triangleshot'
require 'torpedo'
require 'railcannon'
require 'leviathan'
require 'thunderbird'
require 'thunderbirdshockwave'
require 'lightningbolt'
require 'explosionreal'
require 'roundblockenemy'
require 'rayenemy'
require 'enemyrailshot'
require 'enemyrapidshot'
require 'enemytriangleshot'
require 'enemytwinlasershot'
require 'enemyportal'

include Gosu
module StarshipKnights
  module Entities
      @@enemies = Hash.new
      @@enemies["roundblock"] = StarshipKnights::Entities::RoundBlockEnemy
      @@enemies["ray"] = StarshipKnights::Entities::RayEnemy
  
      @@all = Hash.new
    
      @@all["twinlasershot"] = StarshipKnights::Entities::TwinLaserShot
      @@all["wingshot"] = StarshipKnights::Entities::WingShot
      @@all["bomb"] = StarshipKnights::Entities::Bomb
      @@all["phoenix"] = StarshipKnights::Entities::Phoenix
      
      @@all["rapidshot"] = StarshipKnights::Entities::RapidShot
      @@all["spreadshot"] = StarshipKnights::Entities::SpreadShot
      @@all["kitsune"] = StarshipKnights::Entities::Kitsune
      
      @@all["ringshot"] = StarshipKnights::Entities::RingShot
      @@all["tribeam"] = StarshipKnights::Entities::TriBeam
      @@all["rocket"] = StarshipKnights::Entities::Rocket
      @@all["centaurshield"] = StarshipKnights::Entities::CentaurShield
      @@all["centaur"] = StarshipKnights::Entities::Centaur
      
      @@all["waveshot"] = StarshipKnights::Entities::WaveShot
      @@all["disruptshot"] = StarshipKnights::Entities::DisruptShot
      @@all["chargeshot"] = StarshipKnights::Entities::ChargeShot
      @@all["wyvernshockwave"] = StarshipKnights::Entities::WyvernShockwave
      @@all["wyvern"] = StarshipKnights::Entities::Wyvern
      
      @@all["triangleshot"] = StarshipKnights::Entities::TriangleShot
      @@all["torpedo"] = StarshipKnights::Entities::Torpedo
      @@all["railcannon"] = StarshipKnights::Entities::RailCannon
      @@all["leviathan"] = StarshipKnights::Entities::Leviathan
      
      @@all["thunderbird"] = StarshipKnights::Entities::Thunderbird
      @@all["lightningbolt"] = StarshipKnights::Entities::LightningBolt
      @@all["thunderbirdshockwave"] = StarshipKnights::Entities::ThunderbirdShockwave
      
      
      #out["railshot"] = StarshipKnights::Entities::RailShot
      #out["slowmine"] = StarshipKnights::Entities::SlowMine
      #out["djinn"] = StarshipKnights::Entities::Djinn
      
      @@all["explosion"] = StarshipKnights::Entities::ExplosionReal
      #out["asteroid"] = StarshipKnights::Entities::Asteroid
    
      @@all.update(@@enemies)
      @@all["enemyrailshot"] = StarshipKnights::Entities::EnemyRailShot
      @@all["enemyrapidshot"] = StarshipKnights::Entities::EnemyRapidShot
      @@all["enemytriangleshot"] = StarshipKnights::Entities::EnemyTriangleShot
      @@all["enemytwinlasershot"] = StarshipKnights::Entities::EnemyTwinLaserShot
      
      @@all["enemyportal"] = StarshipKnights::Entities::EnemyPortal
    
      module_function
      def all; @@all end
    
      module_function
      def enemies; @@enemies end
  end
end