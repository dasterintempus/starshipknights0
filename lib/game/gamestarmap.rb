require 'gamestarsystem'

include Gosu
module StarshipKnights

  class GameStarMap
  
    def self.starcolors
      return ["yellow", "cyan", "fuschia"]
    end
  
    attr_reader :stars, :width, :height
    
    def initialize(starcount, width, height)
      @width = width
      @height = height
      coords = Array.new
      @width.times.each do |x|
        @height.times.each do |y|
          coords << [x,y] 
        end
      end
      
      chosencoords = coords.sample(starcount)
      
      @stars = Hash.new
      chosencoords.each do |coord|
        @stars[coord] = GameStarSystem.new(GameStarMap.starcolors.sample)
      end
    end
  end

end