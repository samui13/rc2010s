class MapGame
	def initialize
		@map = Map.new
	end

	def play
		@map.move
		@map.show
	end
end
