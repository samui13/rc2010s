class  EnemyGunStrate < EnemyGun
	def move()
		@x -= 10
		super()
	end
end