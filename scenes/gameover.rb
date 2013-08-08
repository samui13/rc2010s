# エンディング画面を表示・管理するクラスの定義
class GameOver
  # コンストラクタにて表示すべき画像を読み込む。
  def initialize
    @ending_image = Image.load("images/gameover_background.png")
  end

  # 背景画像を表示するメソッドを定義
  def draw
    Window.draw(0, 0, @ending_image)
  end

  # Sceneクラスが要求する「play」メソッドを定義
  def play
    # エンディングの画像を描画する。
    draw

    # スペースキーもしくはエンターキーが押されたら
    if Input.keyPush?(K_SPACE) || Input.keyPush?(K_RETURN)
      # プログラム全体を終了させる。
      exit
    end
  end
end
