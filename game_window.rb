require 'gosu'

class GameWindow < Gosu::Window
  attr_accessor :width, :height
  def initialize(width = 640, height = 480)
    @width = width
    @height = height
    super @width, @height
    self.caption = "Gosu Asteroids"
  end

  def update
  end

  def draw
    x_center = width/2
    y_center = height/2
    square_color = Gosu::Color::RED
    draw_quad(x_center, y_center, square_color, x_center, y_center+10, square_color, x_center + 10, y_center + 10, square_color, x_center+10, y_center, square_color, 0.0, :default)
  end
end

window = GameWindow.new
window.show
