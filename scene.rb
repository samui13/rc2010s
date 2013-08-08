# -*- coding: japanese-cp932 -*-

# �V�[���i��ʁj�Ǘ��p�N���X
class Scene
  # �V�[���̈ꗗ���m�ۂ���n�b�V��������������B
  # �N���X�ϐ����g���Ă���_���|�C���g�B
  # �����ɁA�{�Q�[�����ɓo�ꂷ��S�ẴV�[���I�u�W�F�N�g���i�[�����B
  @@scenes = {}

  # ���ݎ��s���ׂ��V�[������ێ�����ϐ�
  @@current_scene_name = nil

  # �V�[���ꗗ�ɃV�[����ǉ�����N���X���\�b�h
  # * scene_obj:  �V�[���̎��̂ƂȂ�I�u�W�F�N�g�B�K���uplay�v���\�b�h�������Ƃ����҂����B
  # * scene_name: �V�[������\���V���{���B������Ŏw�肵�Ă��ǂ��B
  def self.add_scene(scene_obj, scene_name)
    @@scenes[scene_name.to_sym] = scene_obj
  end


  # ���s����V�[����ύX����N���X���\�b�h
  # �{���\�b�h�ɃV�[������n�����ƂŁA�`�悳���V�[����؂�ւ��邱�Ƃ��o����B
  def self.set_current_scene(scene_name)
    @@current_scene_name = scene_name.to_sym
  end


  # ���݂̃V�[����`�悷��N���X���\�b�h
  # �V�[���̎��̂ƂȂ�I�u�W�F�N�g�ɂ́A�K���uplay�v���\�b�h�������Ƃ��ۏ؂���Ă���̂ŁA
  # ���݂̕`��ΏۃV�[���i�̎��̃I�u�W�F�N�g�j�ɑ΂��āuplay�v���\�b�h���Ăяo���A�V�[����
  # �`�悷��B
  def self.play_scene
    @@scenes[@@current_scene_name].play
  end
end
