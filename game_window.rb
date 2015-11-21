require 'gosu'
require_relative 'box'

class GameWindow < Gosu::Window
  attr_accessor :width, :height
  def initialize(width = 640, height = 480)
    @width = width
    @height = height
    super @width, @height
    self.caption = "Gosu Asteroids"
    @box = Box.new(width/2, height/2, 10, 10, Gosu::Color::RED)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft
      @box.move(-2, 0)
    elsif Gosu::button_down? Gosu::KbRight
      @box.move(2, 0)
    elsif Gosu::button_down? Gosu::KbUp
      @box.move(0, -2)
    elsif Gosu::button_down? Gosu::KbDown
      @box.move(0, 2)
    end
  end

  def draw
    draw_quad(@box.x, @box.y, @box.color, @box.x, @box.y + @box.height, @box.color, @box.x + @box.width, @box.y + @box.height, @box.color, @box.x + @box.width, @box.y, @box.color, 0.0, :default)
  end
end

window = GameWindow.new
window.show
