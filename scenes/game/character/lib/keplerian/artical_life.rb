include Math

class Artical_life < EnemyGun
	@@cnt = [1]
	@@car = [0]
	@@gun_counter = 0
	def initialize(x, y, image_file)
		@x = x 
		@y = y
		@gun_img = Image.new(16, 16, [255, 238, 44, 44])
		@flag = nil
		@gun_number = @@gun_counter
		@@gun_counter += 1
	end

	def move
		if @flag
			return 
		end
		if @@cnt[@gun_number] == 1
			@@cnt[@gun_number] = 0
			array=Array.new()
			12.times do |n|
				@@cnt[@@gun_counter] = 50
				@@car[@@gun_counter] = n * (2*3.141592)/12
				array.push(Artical_life.new(@x, @y, "file_name")
			end
		elsif @@cnt[@gun_number]==0
			array=Array.new 
		end
		if array.class == Array
			return array
		end
		r=(@x-Window.width/2)**2+(@y-Window.height/2)**2

		if  sqrt(r) < @@cnt[@gun_number]
			@x=sqrt(r+40)*cos(@@car[@gun_number])+Window.width/2
			@y=sqrt(r+40)*sin(@@car[@gun_number])+Window.height/2
		end
		if sqrt(r).to_i == @@cnt[@gun_number]
			@flag=1
			array= Array.new()
			@@cnt[@@gun_counter] = 100
			@@car[@@gun_counter] = @car
			array.push(Artical_life.new(@x,@y,"file_name"))
			return array
		end
	end
end