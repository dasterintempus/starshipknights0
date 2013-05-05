module StarshipKnights
  module Util
    def Util.rad(d)
      return (Math::PI / 180.0) * d
    end
    
    def Util.deg(r)
      return (180.0 / Math::PI) * r
    end

    def Util.clamp(n, min, max)
      return min if n < min
      return max if n > max
      return n
    end

    def Util.distance(x1, y1, x2, y2)
      dx = x1-x2
      dy = y1-y2
      return Math.sqrt(dx**2 + dy**2)
    end
    
    def Util.angle(x1, y1, x2, y2)
      dx = x2-x1
      dy = y2-y1
      return Util.deg(Math.atan2(dy, dx))
    end 
    
    def Util.vector(d)
      r = Util.rad(d)
      dx = Math.cos(r)
      dy = Math.sin(r)
      return dx, dy
    end
    
    def Util.is_windows?
      RUBY_PLATFORM.downcase.include?("mingw32")
    end
  end
end