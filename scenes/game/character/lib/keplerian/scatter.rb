class  EnemyGunScatter < EnemyGun
	def initialize(x, y, image_file)
		super(x, y, image_file)
		@car = 3.15/4.0
		@postX = x
		@postY = y
	end
	def move()
		r=(@x-@postX)**2+(@y-@postY)**2

		@x = sqrt(r+10)*cos(PI)+@postX
		@y = sqrt(r+10)*sin(PI*1.3)+@postY
		
		super()
	end
end