require 'gosu'
require_relative 'box'
require 'pry'

class GameWindow < Gosu::Window
  attr_accessor :width, :height
  def initialize(width = 640, height = 480)
    @width = width
    @height = height
    super @width, @height
    self.caption = "Gosu Asteroids"
    @box = Box.new(width/2, height/2, 10, 10, Gosu::Color::RED)
    @enemy_boxes = []
    10.times do
      box = Box.new(width/2, height/2, 5, 5, Gosu::Color::WHITE)
      box.randomize_location(width, height)
      @enemy_boxes << box
    end
  end

  def update
    if Gosu::button_down? Gosu::KbLeft
      @box.move(-2, 0, width, height)
    elsif Gosu::button_down? Gosu::KbRight
      @box.move(2, 0, width, height)
    elsif Gosu::button_down? Gosu::KbUp
      @box.move(0, -2, width, height)
    elsif Gosu::button_down? Gosu::KbDown
      @box.move(0, 2, width, height)
    end
  end

  def draw
    draw_quad(@box.x, @box.y, @box.color, @box.x, @box.y + @box.height, @box.color, @box.x + @box.width, @box.y + @box.height, @box.color, @box.x + @box.width, @box.y, @box.color, 0.0, :default)
    @enemy_boxes.each do |enemy_box|
      draw_quad(enemy_box.x, enemy_box.y, enemy_box.color, enemy_box.x, enemy_box.y + enemy_box.height, enemy_box.color, enemy_box.x + enemy_box.width, enemy_box.y + enemy_box.height, enemy_box.color, enemy_box.x + enemy_box.width, enemy_box.y, enemy_box.color, 0.0, :default)
    end
  end
end

window = GameWindow.new
window.show
