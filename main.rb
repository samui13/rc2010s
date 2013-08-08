# -*- coding: utf-8 -*-
$KCODE = 'sjis'

require 'dxruby'
require 'dxrubyex'


# シーンに関するクラス
require 'scene'					# シーン（場面）管理用クラス
require 'scenes/game/game'	# ゲームシーンを制御するクラスを保存しているディレクトリ
require 'scenes/title'	# タイトルシーンのクラス
require 'scenes/ending'	# エンディングシーンのクラス
require 'scenes/gameover'	# ゲームオーバーのクラス

# mapに関するクラス
require './scenes/game/map/game/game'
require './scenes/game/map/game/map'

# characterに関するクラス
require './scenes/game/character/lib/game'



Window.caption = "RubyCamp2010 Example"
Window.width   = 800
Window.height  = 600

game = Game.new
$flag_gameover = false
$flag_clear = false


# ゲーム本体以外のシーン（今回はタイトルシーンとエンディングシーンのみ）
# を表すオブジェクトを生成する。
title  = Title.new
ending = Ending.new
gameover = GameOver.new

# 生成された各シーン（ゲーム本体も1つのシーンと捉える）をSceneクラスの
# 管理下に登録する。
# その際、シーンを区別するための名称をシンボルで渡す。
Scene.add_scene(title,  :title)
Scene.add_scene(game,   :game)
Scene.add_scene(gameover, :gameover)
Scene.add_scene(ending, :ending)

# ゲーム開始直後に描画するべきシーンをSceneクラスに通達する。
Scene.set_current_scene(:title)


Window.loop do
  break if Input.keyPush?(K_ESCAPE)

  # 「game.play」を置き換え、Sceneクラスに現在描画対象となっているシーン
  # を描画するよう命ずる。
  Scene.play_scene
end
