class Player
	def initialize(x, y, img_path)
		@x = x
		@y = y
		@width = 16
		@height = 16

		@collisions = []
		@collisions <<	CollisionCircle.new(self, 17, 18, 12)
		@collisions <<	CollisionBox.new(self, 11, 31, 28, 46)
		@collisions <<	CollisionBox.new(self, 12, 45, 25, 56)

		@collisions.each do |collision|
			collision.set(@x, @y)
		end

		@image = Image.load(img_path)
		@dieflag = false
		@exp = nil
	end

	def gun_shoot()
		if Input.mousePush?(M_LBUTTON)
			return true
		end
	end

	def move()
		posX = Input.mousePosX()
		posY = Input.mousePosY()
		if posX <= 0
			@x = 0
		elsif posX+32 >= Window.width
			@x = Window.width - 32
		end
		if posY<=0
			@y = 0
		elsif posY+32 >= Window.height
			@y = Window.height - 32
		end

		if (posX > 0 && posX < Window.width-32) 
			@x = posX
		end
		if (posY > 0 && posY < Window.height-32)
			@y = posY
		end
		@collisions.each do |collision|
			collision.set(@x, @y)
		end
	end

	def draw()
		unless @dieflag
			Window.draw(@x, @y, @image)
		else
			if @exp.explode
				@collisions.each do |collision|
					collision.set(-100,-100) ########
				end
				$flag_gameover = true
			end
		end
	end

=begin
	def touch(enemies,enemy_bullet)
		enemies.poss.each do |enemy|
			if Collision.check(enemy[:collision], collision)
					die
			end
		end

		#“G‚Ì’e‚Æ‚ÌÕ“Ë
		enemy_bullet.poss.each do |bullet|
			if Collision.check(bullet[:collision], collision)
					die
			end
		end
	end
=end

	def hit(gun_collision)
		die()
		@dieflag = true
		@exp = Explosion.new(@x, @y,:jiki)
#		$flag_gameover = true
#		$flg_clear = true
#		 Explosion.new(@x, @y)
	end

	def die()
		font = Font.new(32)
		Window.drawFont(10,10,"Die",font)
	end

	def collision
		return @collisions
	end

	def dieflag
		return @dieflag
	end
	def x
		return @x
	end
 def y
  return @y
 end
end	