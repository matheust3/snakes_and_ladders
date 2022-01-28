import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/game/game_store.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui_store.dart';

class CobrasEscadas extends FlameGame with HasTappables {
  @override
  Future<void>? onLoad() async {
    sl<GameStore>().game = this;
    sl<GameUiStore>().game = this;
    //Image de fundo
    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('imagem_de_fundo.png')
      ..size = size;
    // Tabuleiro
    SpriteComponent board = SpriteComponent()
      ..anchor = Anchor.topCenter
      ..sprite = await loadSprite('tabuleiro.png')
      ..size = Vector2(size.x - 10, size.y * 0.7)
      ..position = Vector2(size.x * 0.5, 40);

    // Avatares
    sl<GameStore>().avatarRed = SpriteComponent()
      ..anchor = Anchor.topCenter
      ..sprite = await loadSprite('avatar_red.png')
      ..size = Vector2(size.x * 0.05, size.y * 0.035)
      ..position = Vector2(size.x * 0.5, 40);
    sl<GameStore>().avatarBlue = SpriteComponent()
      ..anchor = Anchor.topCenter
      ..sprite = await loadSprite('avatar_blue.png')
      ..size = Vector2(size.x * 0.05, size.y * 0.035)
      ..position = Vector2(size.x * 0.5, 40);

    add(background);
    add(board);

    return await super.onLoad();
  }

  Future<void> jogar(int dado1, int dado2) async {
    overlays.remove('roll_dices_screen');
  }
}
