require 'gameship'
require 'gamestarmap'

include Gosu
module StarshipKnights

  class Game
    
    attr_reader :playeractiveship, :lastbattlestatus
    attr_accessor :difficulty, :score, :currentlevel, :tempscore
    def initialize
      @playeractiveship = nil
      @lastbattlestatus = 0
      @score = 0
      @tempscore = 0
      @currentlevel = 1
    end
    
    def selectship(ship)
      @playeractiveship = GameShip.new(ship)
    end
    
    def spawnplayership(battlestage, x, y, angle, opts=nil)
      return @playeractiveship.spawn(battlestage, x, y, angle, opts)
    end
    
    def losebattle
      @lastbattlestatus = -1
      @tempscore = 0
    end
    
    def winbattle
      @lastbattlestatus = 1
      @currentlevel += 1
      @score += @tempscore
      @tempscore = 0
    end
    
    def resetbattle
      @lastbattlestatus = 0
    end
    
    def generatelevel(width, height, seed=nil)
      enemyvarieties = []
      Entities.enemies.each do |name, enemy|
        enemy.colorvalues.each_key do |color|
          enemyvarieties << [name, color]
        end
      end
    
      r = Random.new(seed) if seed
      r ||= Random.new
      level = {}
      
      #find out how many enemies we want to have
      targetscore = (@currentlevel * 35) + 65
      groupcount = r.rand(1..3)
      enemygroups = enemyvarieties.sample(groupcount, :rng=>r)
      enemygroupcounts = []
      enemygroups.each do |group|
        name = group[0]
        color = group[1]
        count = 0
        enemygroupcounts << [name, color, count]
      end
      actualscore = 0
      n = 0
      totalcount = 0
      while actualscore < targetscore
        enemygroupcounts[n][2] += 1
        actualscore += Entities.enemies[enemygroupcounts[n][0]].colorvalues[enemygroupcounts[n][1]]
        n += 1
        n = n % enemygroupcounts.length
        totalcount += 1
      end
      
      #now to split into portals
      portalcount = (totalcount % 3) + 1
      portals = []
      case portalcount
      when 1
        portals << { "x"=> width/2.0, "y"=> height/3.0 }
        portals[0]["spawns"] = []
        enemygroupcounts.each do |group|
          #all in one portal
          portals[0]["spawns"] << {"klass"=> group[0], "color"=> group[1], "count"=> group[2]}
        end
      when 2
        #first enemy grouping = first portal (left)
        portals << { "x"=> width/4.0, "y"=> height/2.0 }
        portals[0]["spawns"] = [{"klass"=> enemygroupcounts[0][0], "color"=> enemygroupcounts[0][1], "count"=> enemygroupcounts[0][2]}]
        
        #other enemies on the right
        if enemygroupcounts.length >= 2 then
          portals << { "x"=> width*3.0/4.0, "y"=> height/2.0 }
          portals[1]["spawns"] = []
          portals[1]["spawns"] << {"klass"=> enemygroupcounts[1][0], "color"=> enemygroupcounts[1][1], "count"=> enemygroupcounts[1][2]}
          portals[1]["spawns"] << {"klass"=> enemygroupcounts[2][0], "color"=> enemygroupcounts[2][1], "count"=> enemygroupcounts[2][2]} if enemygroupcounts.length == 3
        end
      when 3
        #triangle
        #topright
        portals << { "x"=> width*2.0/3.0, "y"=> height/3.0 }
        portals[0]["spawns"] = []
        #takes half of the first two groups
        portals[0]["spawns"] << {"klass"=> enemygroupcounts[0][0], "color"=> enemygroupcounts[0][1], "count"=> enemygroupcounts[0][2]/2}
        portals[0]["spawns"] << {"klass"=> enemygroupcounts[1][0], "color"=> enemygroupcounts[1][1], "count"=> enemygroupcounts[1][2]/2} if enemygroupcounts.length == 2
        
        #topleft
        portals << { "x"=> width/3.0, "y"=> height/3.0 }
        portals[1]["spawns"] = []
        #takes half of the first two groups, again
        portals[1]["spawns"] << {"klass"=> enemygroupcounts[0][0], "color"=> enemygroupcounts[0][1], "count"=> enemygroupcounts[0][2]/2}
        portals[1]["spawns"] << {"klass"=> enemygroupcounts[1][0], "color"=> enemygroupcounts[1][1], "count"=> enemygroupcounts[1][2]/2} if enemygroupcounts.length == 2
        
        #bottom
        portals << { "x"=> width/2.0, "y"=> height*3.0/4.0 }
        portals[2]["spawns"] = []
        #takes remainder of first two groups and all of last one
        portals[2]["spawns"] << {"klass"=> enemygroupcounts[0][0], "color"=> enemygroupcounts[0][1], "count"=> enemygroupcounts[0][2]%2}
        portals[2]["spawns"] << {"klass"=> enemygroupcounts[1][0], "color"=> enemygroupcounts[1][1], "count"=> enemygroupcounts[1][2]%2} if enemygroupcounts.length == 2
        portals[2]["spawns"] << {"klass"=> enemygroupcounts[2][0], "color"=> enemygroupcounts[2][1], "count"=> enemygroupcounts[2][2]} if enemygroupcounts.length == 3
      end
      level["portals"] = portals
      return level
    end
  end
  
end