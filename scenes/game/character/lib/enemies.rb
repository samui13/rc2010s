class Enemies
	def initialize()
		@poss = []
		@gun_img = Image.load(File.dirname(__FILE__) + "/../img/nashi_min.png")
	end

	def add_enemy(x, y, type)

		@collision = CollisionBox.new(self, 0, 0, @gun_img.width - 1, @gun_img.height - 1)
		array = {:x => x, :y => y,
						 :nextX => x, :nextY => y,
						 :speedX  => 0, :speedY => 0, 
						 :collision => @collision, 
						 :mktime => Time.now.to_i, :sttime => rand(3) + 1,
						 :enemy_HP => 2,:type => type,
						 :dieflag => false, :exp => nil
						}
		array[:collision].set(x, y)
		@poss << array
	end

	def draw
		@poss.each do |pos|
			unless pos[:dieflag]
				Window.draw(pos[:x], pos[:y], @gun_img) 
			else
				pos[:collision].set(-100,-100)
				if pos[:exp].explode
					pos[:dieflag] = false
					@poss.delete(pos)
				end
			end
		end
	end

	def move
		bullet = []
		@poss.each_with_index do |pos, n|
			if pos[:dieflag]
				next
			end
			if Time.now.to_i - pos[:mktime] > pos[:sttime]

				pos[:mktime] = Time.now.to_i
				pos[:sttime] = rand(3) + 1
				bullet << [pos[:x], pos[:y]]

			end

			if pos[:type] == "normal1"
				normal1(pos)
			elsif pos[:type] == "normal2"
				normal2(pos)
			end

			if pos[:x] + 16  <= 0 || pos[:y] + 16 <= 0
				@poss.delete_at(n)
			end
		end
		return bullet
	end


	def normal1(pos)
		if (pos[:nextX] - pos[:x]) ** 2 + (pos[:nextY] - pos[:y]) ** 2 < 2000
			pos[:nextX] = pos[:x] + (rand(10) - 4) * 20
			pos[:nextY] = pos[:y] + (rand(10) - 4) * 20
		end
		if pos[:nextX] <= 0
			pos[:nextX] = 0
			elsif pos[:nextX] + 32 >= Window.width
			pos[:nextX] = Window.width - 32
		end
		if pos[:nextY] <= 0
			pos[:nextY] = 0
		elsif pos[:nextY] + 32 >= Window.height
			pos[:nextY] = Window.height - 32
		end
		pos[:speedX] = pos[:nextX] - pos[:x]   
		pos[:speedY] = pos[:nextY] - pos[:y] 
		pos[:x] += pos[:speedX] / 30
		pos[:y] += pos[:speedY] / 30
		pos[:collision].set(pos[:x], pos[:y])
	end

	def normal2(pos)
		if (pos[:nextX] - pos[:x]) ** 2 + (pos[:nextY] - pos[:y]) ** 2 < 2000
			pos[:nextX] = pos[:x] + (rand(10) -10) * 40
			pos[:nextY] = pos[:y] + (rand(10) - 4) * 10
		end
		pos[:speedX] = pos[:nextX] - pos[:x]   
		pos[:speedY] = pos[:nextY] - pos[:y] 
		pos[:x] += pos[:speedX] / 30
		pos[:y] += pos[:speedY] / 30
		pos[:collision].set(pos[:x], pos[:y])
	end


	def shoot()
			
	end

	def touch(player_bullet)

		@poss.each do |pos|
			player_bullet.poss.each do |play_poss|
				if Collision.check(pos[:collision], play_poss[:collision])
					@poss.delete(pos)
				end
			end
		end
	end

	def poss
		return @poss
	end

	def die
			#@gun_img=Image.new(16,16,[255, 0, 0, 0])
	end

	def hit(gun_collision)
#		unless @your_name == gun_collision
#			@enemy_HP -= 1
#			if @enemy_HP == 0
				die
#			end
#		end
	end

	def hp
		return @enemy_HP
	end

end