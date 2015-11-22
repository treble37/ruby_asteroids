#https://gist.github.com/jlnr/661266

class Circle
  attr_reader :columns, :rows, :color, :x, :y, :radius, :angle, :speed

  def initialize(radius=10, window_width = 640, window_height = 480, color = Gosu::Color::RED)
    @radius = radius
    @columns = @rows = radius * 2
    @x = window_width / 2 #center location by default
    @y = window_height / 2
    @color = color
    @speed = 0.0
    @angle = 270.0
    lower_half = (0...radius).map do |y|
      x = Math.sqrt(radius**2 - y**2).round
      right_half = "#{"\xff" * x}#{"\x00" * (radius - x)}"
      "#{right_half.reverse}#{right_half}"
    end.join
    @blob = lower_half.reverse + lower_half
    @blob.gsub!(/./) { |alpha| "\xff\xff\xff#{alpha}"}
  end

  def move(angle_step, speed_step, x_boundary, y_boundary)
    @angle = (angle + angle_step) % 360
    @speed = [(speed + speed_step), 0].max
    @x = (x + speed * Math.cos(angle*Math::PI/180.0).round(2)) % x_boundary
    @y = (y + speed * Math.sin(angle*Math::PI/180.0).round(2)) % y_boundary
  end

  def randomize_location(x_boundary, y_boundary)
    prng = Random.new
    x_rand = prng.rand(10..x_boundary-10)
    y_rand = prng.rand(10..y_boundary-10)
    @x = x_rand
    @y = y_rand
  end

  def to_blob
    @blob
  end
end

