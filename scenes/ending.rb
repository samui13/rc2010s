
# �G���f�B���O��ʂ�\���E�Ǘ�����N���X�̒�`
class Ending
  # �R���X�g���N�^�ɂĕ\�����ׂ��摜��ǂݍ��ށB
  def initialize
    @ending_image = Image.load("images/ending_background.png")
  end

  # �w�i�摜��\�����郁�\�b�h���`
  def draw
    Window.draw(0, 0, @ending_image)
  end

  # Scene�N���X���v������uplay�v���\�b�h���`
  def play
    # �G���f�B���O�̉摜��`�悷��B
    draw

    # �X�y�[�X�L�[�������̓G���^�[�L�[�������ꂽ��
    if Input.keyPush?(K_SPACE) || Input.keyPush?(K_RETURN)
      # �v���O�����S�̂��I��������B
      exit
    end
  end
end
