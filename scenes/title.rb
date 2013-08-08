# �^�C�g����ʂ�\���E�Ǘ�����N���X�̒�`
class Title
  # �R���X�g���N�^�ɂĕ\�����ׂ��摜��ǂݍ��ށB
  def initialize
    @title_image = Image.load("images/title_background.png")
  end

  # �w�i�摜��\�����郁�\�b�h���`
  def draw
    Window.draw(0, 0, @title_image)
  end

  # Scene�N���X���v������uplay�v���\�b�h���`
  def play
    # �^�C�g���̉摜��`�悷��B
    draw

    # �X�y�[�X�L�[�������ꂽ��
    if Input.keyPush?(K_SPACE)
      # ���̃t���[������́u:game�v�V�[���ɐ؂�ւ���悤�AScene�N���X�ɖ�����B
      Scene.set_current_scene(:game)
    end
  end
end
