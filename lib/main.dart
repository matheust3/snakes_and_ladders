import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui.dart';
import 'package:flutter_snakes_and_ladders/overlays/roll_dice_screen/roll_dice_screen.dart';

import 'overlays/game_ui/game_ui_store.dart';

class CobrasEscadas extends FlameGame with HasTappables {
  @override
  Future<void>? onLoad() async {
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

    // Avatar
    SpriteComponent avatar = SpriteComponent()
      ..anchor = Anchor.topCenter
      ..sprite = await loadSprite('avatar_red.png')
      ..size = Vector2(size.x * 0.05, size.y * 0.035)
      ..position = Vector2(size.x * 0.5, 40);

    add(background);
    add(board);
    add(avatar);

    return await super.onLoad();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    await init();
    runApp(GameWidget<CobrasEscadas>(
      game: CobrasEscadas(),
      initialActiveOverlays: const ['ui'],
      overlayBuilderMap: {
        'ui': (ctx, game) {
          return GameUi(game);
        },
        'roll_dices_screen': (ctx, game) {
          return RollDiceScreen(sl());
        }
      },
    ));
  });
}
