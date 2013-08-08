class  SinWave < EnemyGun
  def initialize(x,y)
		@car=0
		super(x,y)
	end
	def move()
		@x-=5
		@y+=50*sin(@car)
		@car +=10
		super()
	end
end