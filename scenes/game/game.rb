class Game
	def initialize
		@@map_game = MapGame.new
		@@character_game = CharacterGame.new
	end
	
	def play
		@@map_game.play
		@@character_game.play
		
    # 1フレーム描画が終わったら、ゲームクリアとゲームオーバーの条件判定を行う。
    check_gameover
		check_clear
  end


  # ゲームオーバーの条件判定用メソッドを定義
  def check_gameover
		if $flag_gameover
    	Scene.set_current_scene(:gameover)
    end
  end

  # ゲームクリアの条件判定用メソッドを定義
  def check_clear
		if $flag_clear
    	Scene.set_current_scene(:ending)
    end
  end
	
end