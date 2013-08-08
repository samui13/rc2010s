class PlayerBullet

  def initialize()
		@poss = []
		@gun_img = Image.load(File.dirname(__FILE__) + "/../img/shijimi_rev_min.png")
		
	end

	def add_bullet(condition, player)

		unless condition
			return
		end
		@collision = CollisionCircle.new(self, (@gun_img.width - 1) / 2, (@gun_img.height - 1) / 2, (@gun_img.height - 1) / 2)
		array = {:x => player.x + 10, :y => player.y + 15, :collision => @collision,
						 :speed => {:x => 5, :y => -4},
						 :skip  => {:x => 0, :x_to => 3, :y => 0, :y_to => 3},
						 :acceraration => {:x => 3, :y => 1},
						 :valid => true
						}
		array[:collision].set(player.x , player.y )
		@poss << array
	end

	def draw
		@poss.each do |pos|
			Window.draw(pos[:x], pos[:y], @gun_img, 255)
		end
	end

	def move
		@poss.each_with_index do |pos, n|

			pos[:skip][:x] += 1
			pos[:skip][:y] += 1

			if pos[:skip][:y] == pos[:skip][:y_to]
				pos[:skip][:y] = 0
      	pos[:speed][:y] += pos[:acceraration][:y]  
    	end
			if pos[:skip][:x] == pos[:skip][:x_to]
				pos[:skip][:x] = 0
      	pos[:speed][:x] += pos[:acceraration][:x]
    	end
			pos[:x] += pos[:speed][:x]
			pos[:y] += pos[:speed][:y]

			pos[:collision].set(pos[:x], pos[:y])
			if pos[:x] + 16 <= 0 || pos[:x] - 16 >= Window.width || pos[:y] + 16 <= 0 || pos[:y] - 16 >= Window.height
				@poss.delete_at(n)
			end
		end
	end
	
	
	def touch(enemies)

	end

	def poss
		return @poss
	end

	def die()
		return self
	end

	def shot(collision_object)
	end
	def hit(collision_gun)

	end
end