class Orochi 
	def initialize(x, y, image_file)
		@orochi_HP = 50
		@x = -1000
		@y = -1000
		@emage_flag = false
		@orh_body = Image.load(File.dirname(__FILE__) + "/../img/oroti_body.png")
		@orh_head = Image.load(File.dirname(__FILE__) + "/../img/oroti_head.png")
		@orh_neck = Image.load(File.dirname(__FILE__) + "/../img/oroti_neck.png")

		@hd_pos = {:x =>  -200, :y => -300, :nextX => -200, :nextY => -300, :baseX => -200, :baseY => -150}
		@hd_spd = {:x =>  2, :y => 2}
		@hd_timer = {:mktime => Time.now.to_i, :sttime => 17}

		@cls_ms = []
		@cls_bds  = []
		@cls_hds  = []
		@cls_nks  = []
		
		@cls_bds << CollisionCircle.new(self, 100, 150, 80)
		@cls_bds << CollisionTriangle.new(self, 170, 7, 80, 77, 180, 120)
		@cls_hds << CollisionCircle.new(self, 66, 41, 30)
		@cls_hds << CollisionTriangle.new(self, 52, 20, 9, 65, 60, 81)
		@cls_hds << CollisionCircle.new(self, 12, 77, 11)
		@cls_hds << CollisionTriangle.new(self, 110, 17, 88, 38, 88, 38)
		@neck_num = 4
		@neck_num.times do
			@cls_nks << CollisionCircle.new(self, 30, 20, 25)
		end
		@cls_ms += @cls_hds
		@cls_ms += @cls_bds
		@cls_ms += @cls_nks 
		
		@cls_hds.each do |cls_hd|
			cls_hd.set(@x + @hd_pos[:x], @y + @hd_pos[:y])
		end
		@cls_bds.each do |cls_bd|
			cls_bd.set(@x, @y)
		end
		@cls_nks.each_with_index do |cls_nk, n|
			cls_nk.set(@x + @hd_pos[:x] * n / (@neck_num + 1), @y + @hd_pos[:y] * n / (@neck_num + 1))
		end

		@exp = []
		@dieflag = nil
		@mktime = 0
	end

	def emage
		@x = 1000
		@y = 350
		@emage_flag = true
	
	end

	def move
		@x += -1 if @x >= 550 
			if (@hd_pos[:nextX] - @hd_pos[:x]) ** 2 + (@hd_pos[:nextY] - @hd_pos[:y]) ** 2 < 2000
	 			@hd_pos[:nextX] = @hd_pos[:x] + (rand(10) - 4) * 20
				@hd_pos[:nextY] = @hd_pos[:y] + (rand(10) - 4) * 20
			end
			if @hd_pos[:nextX] <= @hd_pos[:baseX] - 100
				@hd_pos[:nextX] = @hd_pos[:baseX] - 100
			elsif @hd_pos[:nextX] >= @hd_pos[:baseX] + 100
				@hd_pos[:nextX] = @hd_pos[:baseX] + 100
			end
			if @hd_pos[:nextY] <= @hd_pos[:baseY] - 100
				@hd_pos[:nextY] = @hd_pos[:baseY] - 100
			elsif @hd_pos[:nextY] >= @hd_pos[:baseY] + 100
				@hd_pos[:nextY] = @hd_pos[:baseY] + 100
			end  
			@hd_pos[:x] += (@hd_pos[:nextX] - @hd_pos[:x]) / 30
			@hd_pos[:y] += (@hd_pos[:nextY] - @hd_pos[:y]) / 30

			bullet = []
			if Time.now.to_i - @hd_timer[:mktime] > @hd_timer[:sttime]
				@hd_timer[:mktime] = Time.now.to_i
				@hd_timer[:sttime] = rand(3) + 1
				bullet << [@x + @hd_pos[:x], @y + @hd_pos[:y] + 50]

			end

		@cls_bds.each do |cls_bd|
			cls_bd.set(@x, @y)
		end
		@cls_hds.each do |cls_hd|
			cls_hd.set(@x + @hd_pos[:x], @y + @hd_pos[:y])
		end
		@cls_nks.each_with_index do |cls_nk, n|
			cls_nk.set(@x + @hd_pos[:x] * n / (@neck_num + 1), @y + @hd_pos[:y] * n / (@neck_num + 1))
		end
		return bullet
	end
	def draw
		unless @dieflag
			Window.draw(@x, @y, @orh_body)
			Window.draw(@x + @hd_pos[:x], @y + @hd_pos[:y], @orh_head)
			@cls_nks.each_with_index do |cls_nk, n|
				Window.draw(@x + @hd_pos[:x] * n  / (@neck_num + 1), @y + @hd_pos[:y] * n / (@neck_num + 1), @orh_neck)		
			end
			if @emage_flag == true
				Window.draw(Window.width - @orochi_HP * 2 - 20, Window.height - 30, Image.new(@orochi_HP * 3, 20, [255, 238, 238, 44]), 255)
			end
		end
		
		if Time.now.to_i - @mktime > 1 && @dieflag == true
			$flag_clear = true
		end
		
		if !@exp.empty?
			@exp.each do |explode|
				explode.explode
			end
		end
#			@exp << Explosion(@x, @y, :boss)
#Explosion.new(@x + @hd_pos[:x] * rand(10) / 10 + (rand(10) - 5) * 5,
#														@y + @hd_pos[:y] * rand(10) / 10  + (rand(10) - 5) * 5,:boss)

	end
	def collision
		return @cls_ms
	end
	def collision_head
		return @cls_hds
	end
	def damage(x,y)
			if @orochi_HP >= 1
				@orochi_HP -= 1
				if @orochi_HP == 0
					@dieflag = true
					@mktime = Time.now.to_i
					12.times do
						@exp << Explosion.new(@x + @hd_pos[:x] * rand(10) / 10 + (rand(10) - 5) * 5,
														@y + @hd_pos[:y] * rand(10) / 10  + (rand(10) - 5) * 5,:boss)
					end
					@cls_ms.each do |collision|
						collision.set(-500,-500)
					end
				end
				@exp << Explosion.new(x, y, :boss)
			elsif @orochi_HP ==0

				die
			end
		
	end

	def die
=begin
		12.times do |n|
			@x + @hd_pos[:x]
			@exp << Explosion.new()
		end

		@x, @y = -1000, -1000
		@cls_ms.each do |part|
			part.set(@x, @y)
		end
=end
	end

	def exp
		return @exp
	end
	def hp
		return @orochi_HP
	end
	
end
