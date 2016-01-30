#https://gist.github.com/jlnr/661266

class Circle
  attr_reader :columns, :rows, :color, :x, :y, :radius, :angle, :speed

  def initialize(radius=10, window_width = 640, window_height = 480, color = Gosu::Color::RED, x=640/2, y=480/2, speed=0.0, angle=270.0)
    @radius = radius
    @columns = @rows = radius * 2
    @x = x
    @y = y
    @color = color
    @speed = speed
    @angle = angle
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
    @speed = [@speed, 7].min
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

