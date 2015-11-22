require 'gosu'
require_relative 'box'
require_relative 'circle'
require 'pry'

class GameWindow < Gosu::Window
  attr_accessor :width, :height

  def initialize(width = 640, height = 480)
    @width = width
    @height = height
    super @width, @height
    self.caption = "Gosu Asteroids"
    @circle = Circle.new(10, width, height, Gosu::Color::RED)
    @img_circle = Gosu::Image.new(self, @circle, false)
    @enemy_circles = []
    @enemy_img_circles = []
    @bullets = []
    @bullet_imgs = []
    10.times do
      circle = Circle.new(12, width, height, Gosu::Color::WHITE)
      circle.randomize_location(width, height)
      @enemy_circles << circle
      @enemy_img_circles << Gosu::Image.new(self, circle, false)
    end
  end

  def update
    speed_step = 0.0
    angle_step = 0.0
    if Gosu::button_down? Gosu::KbLeft
      angle_step = -0.5
    elsif Gosu::button_down? Gosu::KbRight
      angle_step = 0.5
    elsif Gosu::button_down? Gosu::KbUp
      speed_step = 0.25
    elsif Gosu::button_down? Gosu::KbDown
      speed_step = -0.25
    elsif Gosu::button_down? Gosu::KbSpace
      bullet = Bullet.new(2, width, height, Gosu::Color::BLUE, @circle.x, @circle.y, @circle.speed + 2.0, @circle.angle)
      @bullets << bullet
      @bullet_imgs << Gosu::Image.new(self, bullet, false)
    end
    @bullets.each do |bullet|
      bullet.move
      bullet = nil if !bullet.onscreen?(width, height)
    end
    @circle.move(angle_step, speed_step, width, height)
    close if collision?
  end

  def draw
    @bullet_imgs.each_with_index do |image, i|
      image.draw @bullets[i].x, @bullets[i].y, 0, 1, 1, @bullets[i].color, :default
    end
    @img_circle.draw @circle.x,@circle.y, 0, 1, 1, @circle.color,:default
    @enemy_img_circles.each_with_index do |circle, i|
      circle.draw @enemy_circles[i].x, @enemy_circles[i].y, 0, 1, 1, @enemy_circles[i].color, :default
    end
  end

  def collision?
    collision = false
    @enemy_circles.each do |enemy|
      dx = (@circle.x - enemy.x)**2
      dy = (@circle.y - enemy.y)**2
      distance = Math.sqrt(dx+dy)
      if (distance < (@circle.radius + enemy.radius))
        collision = true
      end
      break if collision
    end
    collision
  end

end

window = GameWindow.new
window.show
