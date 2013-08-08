class Map

	def initialize
		@chip = 16 		# マップチップが32×32(pixel)
		@walk = 2 		# マップをスクロールさせる量（速度）(0, 32×mapfile.size)
		
		# 全マップ中の表示部分座標
		@x = 0				# 画面左上のx座標
		@x_bg = 0			# 遠景のx座標
		@x_inc = 0.02 # 遠景のx座標の増分
		@max_x = 0
		
		# マップファイルの読み込み
		@image = Image.loadToArray('./scenes/game/map/images/map_chips.png', 4, 4)	# map_chips.png = 4 * 4
		@MAP_FILE = './scenes/game/map/map/final.map'
		@mapfile = []
		@bg = Image.load('./scenes/game/map/images/bg.jpg')
		mapLoad
		# マップを画面に表示する
    margin = 2
		@show_x = Window.width / @chip + margin
		@show_y = @mapfile.size
    @offset_y = -150 #Window.height / 2
	end


	# マップファイルの読み込み
	def mapLoad
		open(@MAP_FILE).each do |line|
			cols = line.chomp.split(/\s*,\s*/)
			@mapfile << cols
			@max_x = cols.size if cols.size > @max_x
		end
		
#		@max_y = @mapfile.size
	end


	# マップの表示
	def show
		sx = @x % @chip
		Window.draw(@x_bg, 0, @bg) # (0, 0, @bg)
		
		@show_y.times do |y|
			@show_x.times do |x|
				mapx = @x / @chip
				a = @mapfile[y][mapx + x].to_i
				next if a == 0
				Window.draw(x * @chip - sx, (y * @chip) + @offset_y, @image[a])
			end
		end
	end

	def move
		self.right() # if Input.x > 0
	end

	def right
		@x += @walk
		@x_bg -= @x_inc
		if @x > @max_x * @chip - Window.width
			@x = @max_x * @chip - Window.width
			@x_inc = 0
		end
	end


end