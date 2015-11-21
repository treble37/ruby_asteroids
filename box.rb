class Box
  attr_accessor :x, :y, :width, :height, :color

  def initialize(x, y, width, height, color=Gosu::Color::RED)
    @x = x
    @y = y
    @width = width
    @height = height
    @color = color
  end

  def move(x, y)
    @x += x
    @y += y
  end

end
