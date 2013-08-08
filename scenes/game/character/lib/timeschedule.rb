require 'yaml'

class TimeSchedule
	def initialize(sTime)
		file = open(File.dirname(__FILE__) + "/scene.yaml")
		str = file.read
		@data = YAML.load(str)
		@nextSche = 0
		@sTime = sTime
		@flag = true
	end

	def checkSche(enemy)
		if @data.size <= @nextSche
			return
		end
		if Time.now.to_i - @sTime == @data[@nextSche]["mktime"] && @flag == true
			enemies = Array.new()
			@data[@nextSche]["enum"].times do
				if @data[@nextSche]["type"] == "normal1"
					enemy.add_enemy(rand(Window.width/2)+Window.width,rand((Window.height)/2), "normal1")
				elsif @data[@nextSche]["type"] == "normal2"
					enemy.add_enemy(rand(Window.width/2)+Window.width,rand((Window.height)/2), "normal2")
				end
			end
			@flag = false
			return enemies
		end
		if Time.now.to_i - @sTime != @data[@nextSche]["mktime"] && @flag == false
			if @data.size > @nextSche
				@nextSche+=1
			end
			@flag = true
		end
	end

	def nextSche()
		return @nextSche
	end
end