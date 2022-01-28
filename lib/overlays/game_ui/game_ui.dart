import 'package:flutter/material.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/main.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui_store.dart';

class GameUi extends StatelessWidget {
  const GameUi(this.game, {Key? key}) : super(key: key);

  final CobrasEscadas game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            top: ((game.size.y * 0.3 - 40) / 2) + game.size.y * 0.7,
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 60,
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => sl<GameUiStore>().play(),
                  child: Image.asset(
                    'assets/images/dices_icon.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
