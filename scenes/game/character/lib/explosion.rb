class Explosion
	
	@@se1 = Sound.new(File.dirname(__FILE__)+"/../soundeffect/boss_explosion.wav")
	@@se2 = Sound.new(File.dirname(__FILE__)+"/../soundeffect/zako_explosion.wav")
	@@se3 = Sound.new(File.dirname(__FILE__)+"/../soundeffect/jiki_explosion.wav")
	
	@@sound = {:boss => @@se1,
						 :zako => @@se2,
						 :jiki => @@se3 }
	
	@@sound[:boss].setVolume(255)
	@@sound[:zako].setVolume(255)
	@@sound[:jiki].setVolume(255)
	
	
	def initialize(character_x, character_y, type)
		@img = Image.new(100, 100, [0, 0, 0, 0])
		@x = character_x
		@y = character_y
		
		@rad = 0
		@alpha = 255
		@red  = [@alpha, 255, 0, 0]
		@yellow = [@alpha, 255, 255, 0]
		@flame_color = @red

		@type = type
	end
	
	def explode
		Window.draw(@x, @y, @img.circleFill(25, 25, @rad, @flame_color))
		@rad += 1 if @rad <= 25
		@flame_color[0] -= 5 if @flame_color[0] > 0
		
		@flame_color = @yellow if @rad % 2 == 0
		@flame_color = @red if @rad % 2 == 1
		
		@@sound[@type].play if @rad == 1

		return true if @rad >= 25
	end
end