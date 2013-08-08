class	OrochiBullet
	def initialize
		@poss = []
		@gun_img = Image.load(File.dirname(__FILE__) + "/../img/oroti_tama_min.png" )
	end

	def	add_bullet(addpos)
		addpos.each do |pos|
			@collision = CollisionCircle.new(self, 21, 21, 10)
			hash ={:x => pos[0], :y => pos[1], :speedX => 0, :speedY => 0, :collision => @collision}
			hash[:collision].set(pos[0], pos[1])
			@poss << hash
		end
	end


	def move
		@poss.each_with_index do |pos , n|
			nowPos = {:x => Input.mousePosX(), :y => Input.mousePosY()}
			if nowPos[:x] <= 0
				nowPos[:x] = 0
			elsif nowPos[:x] + 32 >= Window.width
				nowPos[:x] = Window.width - 32
			end
			if nowPos[:y] <=0
				nowPos[:y] = 0
			elsif nowPos[:y] + 32 >= Window.height
				nowPos[:y] = Window.height - 32
			end
			
			pos[:speedX] += (nowPos[:x] - pos[:x]) / 100
			pos[:speedY] += (nowPos[:y] - pos[:y]) / 100
			
			pos[:x] += pos[:speedX] 
			pos[:y] += pos[:speedY]
			pos[:collision].set(pos[:x], pos[:y])
			if pos[:x] + 16 <= 0 || pos[:x] - 16 >= Window.width || pos[:y] + 16 <= 0 || pos[:y] - 16 >= Window.height
				@poss.delete_at(n)
			end
		end
	end

	def draw
		@poss.each do |pos|
			Window.draw(pos[:x], pos[:y], @gun_img)
		end
	end

	def poss
		return @poss
	end

end