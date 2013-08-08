include Math

class EnemyGunFirework < EnemyGun
	#cnt‚Ç‚±‚Ü‚Ås‚­‚©
	#carŠp“x
	@@cnt = [1]
	@@car = [0]
	@@gun_counter = 0
  @@postX = 0
	@@postY = 0
	def initialize(x, y, image_file, c,car)
		super(x, y, image_file)
		if @@gun_counter == 0
			@@postX = x
			@@postY = y
		end
		@x = x
		@y = y
		@gun_img=Image.new(16,16,[255, 44, 238, 88])
		@flag=nil
		@gun_number = @@gun_counter
		@car = car
		@cnt = c
		@gun_counter = @@gun_counter + 1
		@offsetX = rand(20)
	end

	def move()
		if @x > Window.width/2 && @cnt==0
			@x -= 10
		elsif (@x <= (Window.width / 2) + @offsetX ) && 
					(@x >= (Window.width / 2) - @offsetX ) && 
					@cnt==0 ## (@@gun_counter == 0)
				array = Array.new()
				12.times do |n|
					array.push(EnemyGunFirework.new(@x,@y,"file",50,n*(2*3.141592)/12))
				end
				@cnt=1
				@@gun_counter = 0
				return array
		elsif (@cnt>0) && sqrt((@x-@@postX)**2+(@y-@@postY)**2) <= @cnt
			r=(@x-@@postX)**2+(@y-@@postY)**2
			@x=sqrt(r+40)*cos(@car)+@@postX
			@y=sqrt(r+40)*sin(@car)+@@postY
		elsif (@cnt>0) && sqrt(((@x-@@postX)**2+(@y-@@postY)**2)-2) >= @cnt
			@x -= 10
	
    end
		super()
	end

end