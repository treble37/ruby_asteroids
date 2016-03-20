class Bullet < Circle

  def move
    @angle = angle % 360.0
    @x = (x + speed * Math.cos(angle*Math::PI/180.0).round(2))
    @y = (y + speed * Math.sin(angle*Math::PI/180.0).round(2))
  end

  def onscreen?(x_boundary, y_boundary)
    x < x_boundary && y < y_boundary
  end

end
