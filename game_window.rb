require 'gosu'
require_relative 'box'
require_relative 'circle'
require_relative 'bullet'
require 'pry'

class GameWindow < Gosu::Window
  attr_accessor :width, :height

  def initialize(width = 640, height = 480)
    @width = width
    @height = height
    super @width, @height
    self.caption = "Gosu Asteroids"
    @ship_head, @ship_body, @img_ship_head, @img_ship_body = create_ship
    @asteroids = []
    @img_asteroids = []
    @asteroids, @img_asteroids = create_asteroids
    @bullets = []
    @bullet_imgs = []
  end

  def update
    speed_step = 0.0
    angle_step = 0.0
    if Gosu::button_down? Gosu::KbLeft
      angle_step = -2.0
    elsif Gosu::button_down? Gosu::KbRight
      angle_step = 2.0
    elsif Gosu::button_down? Gosu::KbUp
      speed_step = 3*(0.25)**2 - 2*(0.25)**3 #smooth step curve
    elsif Gosu::button_down? Gosu::KbDown
      speed_step = -0.25
    elsif Gosu::button_down? Gosu::KbSpace
      create_bullets
    end
    move_bullets
    move_asteroids
    move_ship(angle_step, speed_step)
    asteroid_hit?
    close if collision?
  end

  def draw
    @bullet_imgs.each_with_index do |image, i|
      image.draw @bullets[i].x, @bullets[i].y, 0, 1, 1, @bullets[i].color, :default
    end
    @img_ship_body.draw @ship_body.x,@ship_body.y, 0, 1, 1, @ship_body.color,:default
    @img_ship_head.draw @ship_head.x + (@ship_body.radius)*Math.cos(@ship_body.angle*Math::PI/180.0).round(2), @ship_head.y + (@ship_body.radius)*Math.sin(@ship_body.angle*Math::PI/180).round(2), 0, 1, 1, @ship_head.color,:default
    @img_asteroids.each_with_index do |circle, i|
      circle.draw @asteroids[i].x, @asteroids[i].y, 0, 1, 1, @asteroids[i].color, :default
    end
  end

  def collision?
    collision = false
    @asteroids.each do |enemy|
      dx = (@ship_body.x - enemy.x)**2
      dy = (@ship_body.y - enemy.y)**2
      distance = Math.sqrt(dx+dy)
      if (distance < (@ship_body.radius + enemy.radius))
        collision = true
      end
      break if collision
    end
    collision
  end

  def asteroid_hit?
    hit = false
    delete_index = nil
    @asteroids.each_with_index do |enemy, i|
      @bullets.each do |bullet|
        dx = (bullet.x - enemy.x)**2
        dy = (bullet.y - enemy.y)**2
        distance = Math.sqrt(dx + dy)
        if (distance < (bullet.radius + enemy.radius))
          hit = true
          delete_index = asteroid_split_or_delete_index(i)
        end
      end
    end
    if delete_index
      @asteroids.delete_at(delete_index)
      @img_asteroids.delete_at(delete_index)
    end
    hit
  end

  def asteroid_split_or_delete_index(i)
    min_delete_radius = 4
    new_asteroid_radius = @asteroids[i].radius / 2
    if (new_asteroid_radius > min_delete_radius)
      circle_x = @asteroids[i].x
      circle_y = @asteroids[i].y
      circle_speed = @asteroids[i].speed
      circle_angle = @asteroids[i].angle + 90
      (0..1).each do |j|
        mult = (j%2==0) ? 1 : -1
        circle = Circle.new(new_asteroid_radius, width, height, Gosu::Color::WHITE, circle_x, circle_y, circle_speed, mult*circle_angle)
        @asteroids << circle
        @img_asteroids << Gosu::Image.new(self, circle, false)
      end
    end
    i
  end

  private

  def create_ship
    ship_radius = 10
    ship_body = Circle.new(ship_radius, width, height, Gosu::Color::RED, width/2, height/2, 0.0, 270.0)
    ship_head = Circle.new(ship_radius/2, width, height, Gosu::Color::GREEN, width/2 + ship_radius/2, height/2 + ship_radius/2, 0.0, 270.0)
    img_circle = Gosu::Image.new(self, ship_body, false)
    img_ship_head = Gosu::Image.new(self, ship_head, false)
    [ship_head, ship_body, img_ship_head, img_circle]
  end

  def create_asteroids
    prng = Random.new
    asteroids = []
    img_asteroids = []
    10.times do
      circle = Circle.new(12, width, height, Gosu::Color::WHITE, 0, 0, 1.0, prng.rand(1..359))
      circle.randomize_location(width, height)
      asteroids << circle
      img_asteroids << Gosu::Image.new(self, circle, false)
    end
    [asteroids, img_asteroids]
  end

  def create_bullets
    bullet_radius = 2
    bullet = Bullet.new(bullet_radius, width, height, Gosu::Color::BLUE, @ship_body.x + @ship_head.radius + bullet_radius, @ship_body.y + @ship_head.radius + bullet_radius, @ship_body.speed + 2.0, @ship_body.angle)
    @bullets << bullet
    @bullet_imgs << Gosu::Image.new(self, bullet, false)
  end

  def move_bullets
    @bullets.each do |bullet|
      bullet.move
      bullet = nil if !bullet.onscreen?(width, height)
    end
  end

  def move_asteroids
    prng_move = Random.new
    @asteroids.each do |asteroid|
      asteroid.move(0, 0.0, width, height)
    end
  end

  def move_ship(angle_step, speed_step)
    @ship_body.move(angle_step, speed_step, width, height)
    @ship_head.move(angle_step, speed_step, width, height)
  end

end

window = GameWindow.new
window.show
