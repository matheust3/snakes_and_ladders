import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/overlays/alert_screen/alert_screen.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui.dart';
import 'package:flutter_snakes_and_ladders/overlays/roll_dice_screen/roll_dice_screen.dart';

import 'game/cobras_escadas.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    await init();
    runApp(GameWidget<CobrasEscadas>(
      game: CobrasEscadas(),
      initialActiveOverlays: const ['ui', 'alert_screen'],
      overlayBuilderMap: {
        'ui': (ctx, game) {
          return GameUi(game);
        },
        'roll_dices_screen': (ctx, game) {
          return RollDiceScreen(sl());
        },
        'alert_screen': (ctx, game) {
          return const AlertScreen();
        }
      },
    ));
  });
}
