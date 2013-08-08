require File.dirname(__FILE__)+'/timeschedule'
require File.dirname(__FILE__)+'/player'
require File.dirname(__FILE__)+'/player_bullet'
require File.dirname(__FILE__)+'/enemies'
require File.dirname(__FILE__)+'/enemy_bullet'
require File.dirname(__FILE__)+'/explosion'
require File.dirname(__FILE__)+'/option'
require File.dirname(__FILE__)+'/orochi'
require File.dirname(__FILE__)+'/orochi_bullet'

class CharacterGame
	def initialize
		#Window.width = 900
		#Window.height = 600
		@player_image = File.dirname(__FILE__)+"/../img/player.png"
		@player = Player.new(0, 0, @player_image)
		@option = Option.new(0, 0, "file_name")
		@orochi = Orochi.new(0, 0, "file_name")

		@enemies = Enemies.new()
		@player_bullet = PlayerBullet.new()
		@enemy_bullet  = EnemyBullet.new()
		@orochi_bullet = OrochiBullet.new()

		@mktime = Time.now.to_i
		@stflag = false

		@explodes = []
		
		#@tschedule = TimeSchedule.new(@mktime)
		@ar = Array.new
	end

	def play
		unless @stflag
			@mktime = Time.now.to_i
			@tschedule = TimeSchedule.new(@mktime)
			@stflag = true
		end
		# ƒXƒPƒWƒ…[ƒ‹ŠÇ—
		@tschedule.checkSche(@enemies)
		if Time.now.to_i - @mktime == 17 
				@orochi.emage
		end
		@player.draw()
		@player.move()	unless @player.dieflag

		Collision.check(@enemies.poss.collect{|line| line[:collision]}, @player.collision)  unless @player.dieflag
		#“G‚Ì’e‚ÆŽ©•ª‚ÌÕ“Ë
		@enemy_bullet.poss.each do |e_bullet|
			if Collision.check(e_bullet[:collision], @player.collision)
				@enemy_bullet.poss.delete(e_bullet)
			end
		end
		#‘åŽÖ‚Ì’e‚ÆŽ©•ª‚ÌÕ“Ë
		@orochi_bullet.poss.each do |o_bullet|
			if Collision.check(o_bullet[:collision], @player.collision)
				@orochi_bullet.poss.delete(o_bullet)
			end
		end
		Collision.check(@orochi.collision, @player.collision)

		@player_bullet.add_bullet(@player.gun_shoot(),@player)
		@player_bullet.draw
		@player_bullet.move

		@enemies.draw
		ar =@enemies.move

		@player_bullet.poss.each do |p_bullet|
			if Collision.check(p_bullet[:collision], @enemies.poss.collect{|line| line[:collision]})
				p_bullet[:vaild] = false
				p_bullet[:speed][:x] = (rand(5) - 2) * 5
				p_bullet[:speed][:y] = (rand(5) - 2) * 5
				p_bullet[:acceraration][:x] = -1
				p_bullet[:acceraration][:y] = 2
			end
		end
		#‹Ê‚Æ“G‚ÌÕ“Ë
		@enemies.poss.each do |enemy|
			if Collision.check(@player_bullet.poss.collect{|line| line[:collision]}, enemy[:collision])
				if enemy[:enemy_HP] > 0
					enemy[:enemy_HP] -= 1
				end
			end
			if enemy[:enemy_HP] == 0
				enemy[:enemy_HP] = 1
				enemy[:dieflag] = true
				enemy[:exp] = Explosion.new(enemy[:x], enemy[:y], :zako)
#				 @enemies.poss.delete(enemy)
			end
		end
		
		@enemy_bullet.add_bullet(ar) if ar.class == Array && !ar.empty?
		@enemy_bullet.move
		@enemy_bullet.draw
		

		@player_bullet.poss.each do |p_bullet|
			if Collision.check(p_bullet[:collision], @orochi.collision)
				if p_bullet[:valid] == true
					if Collision.check(p_bullet[:collision], @orochi.collision_head)
						@orochi.damage(p_bullet[:x], p_bullet[:y])
					end
				end
				p_bullet[:speed][:x] = (rand(3) - 2) * 2
				p_bullet[:speed][:y] = (rand(3) - 2) * 2
				p_bullet[:acceraration][:x] = 0
				p_bullet[:acceraration][:y] = 2
				p_bullet[:valid] = false
			end
		end

		unless @orochi.hp() ==0
			@orochi.draw
			ar = @orochi.move
			@orochi_bullet.add_bullet(ar) if ar.class == Array && !ar.empty?
			@orochi_bullet.move
			@orochi_bullet.draw
		else
			@orochi.draw

		end
	end

end
