class Option 
	
	def initialize(x, y, image_file)
		
		@x = x
		@y = y
		@image = Image.new(16, 16, [255, 238, 238, 44])
    @speed = {:x => 0, :y => 0}
		@option_deray = 15
	end
	def gun_shoot()
		if Input.mousePush?(M_LBUTTON)
			return Player_gun.new(@x,@y,"image_file")
		end
	end

	def move()
		posX = Input.mousePosX()
		posY = Input.mousePosY()
		if posX <= 0
			posX = 0
		elsif posX + 16 >= Window.width
			posX = Window.width - 16
		end
		@speed[:x] = (@x - posX) / @option_deray
		@x -= @speed[:x] 

		if posY<=0
			posY = 0
		elsif posY + 16 >= Window.height
			posY = Window.height - 16
		end
		@speed[:y] = (@y - posY) / @option_deray
		@y -= @speed[:y]

		
	end

	def draw()
		Window.draw(@x, @y, @image)
	end

	
	def hit(gun_collision)
		die()
	end

	def die()
		font = Font.new(32)
		Window.drawFont(10,10,"Die",font)
	end

	def x
		return @x
	end
 def y
  return @y
 end
end
