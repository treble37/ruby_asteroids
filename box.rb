class Box
  attr_accessor :x, :y, :width, :height, :color

  def initialize(x, y, width, height, color=Gosu::Color::RED)
    @x = x
    @y = y
    @width = width
    @height = height
    @color = color
  end

  def move(x, y, x_boundary, y_boundary)
    @x = (@x + x) % x_boundary
    @y = (@y + y) % y_boundary
  end

  def randomize_location(x_boundary, y_boundary)
    prng = Random.new
    x_rand = prng.rand(10..x_boundary-10)
    y_rand = prng.rand(10..y_boundary-10)
    @x = x_rand
    @y = y_rand
  end

end
