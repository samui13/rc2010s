class Game
	def initialize
		@@map_game = MapGame.new
		@@character_game = CharacterGame.new
	end
	
	def play
		@@map_game.play
		@@character_game.play
		
    # 1�t���[���`�悪�I�������A�Q�[���N���A�ƃQ�[���I�[�o�[�̏���������s���B
    check_gameover
		check_clear
  end


  # �Q�[���I�[�o�[�̏�������p���\�b�h���`
  def check_gameover
		if $flag_gameover
    	Scene.set_current_scene(:gameover)
    end
  end

  # �Q�[���N���A�̏�������p���\�b�h���`
  def check_clear
		if $flag_clear
    	Scene.set_current_scene(:ending)
    end
  end
	
end