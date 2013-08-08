class	EnemyBullet
	def initialize
		@poss = []
		@gun_img = Image.load(File.dirname(__FILE__) + "/../img/tane_min.png" )
	end

	def	add_bullet(addpos)
		addpos.each do |pos|
			@collision = CollisionBox.new(self, 0, 0, @gun_img.width - 1, @gun_img.height - 1)
			hash ={:x => pos[0], :y => pos[1], :speedX => -5, :speedY => rand(3) - 1, :collision => @collision}
			hash[:collision].set(pos[0], pos[1])
			@poss << hash
		end
	end
	

	def move
		@poss.each_with_index do |pos,n|
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