import 'package:flutter/material.dart';
import 'package:flutter_snakes_and_ladders/core/failures.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/game/cobras_escadas.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'game_ui_store.dart';

class GameUi extends StatelessWidget {
  GameUi(this.game, {Key? key}) : super(key: key);

  final arrowAnimationController = _ArrowAnimationController(
    startPosition: 40,
    endPosition: 60,
    animationDuration: const Duration(milliseconds: 500),
  );

  final CobrasEscadas game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ScopedBuilder<GameUiStore, Failure, GameUiState>(
        store: sl<GameUiStore>(),
        onState: (context, state) => Stack(
          children: [
            if (state.isBlueTurn)
              AnimatedBuilder(
                animation: arrowAnimationController,
                builder: (context, _) {
                  return AnimatedPositioned(
                      child: const Icon(
                        Icons.arrow_left_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                      top: ((game.size.y * 0.3 - 40) / 2) + game.size.y * 0.7 + 20,
                      left: arrowAnimationController.position,
                      duration: arrowAnimationController.animationDuration);
                },
              ),
            if (!state.isBlueTurn)
              AnimatedBuilder(
                animation: arrowAnimationController,
                builder: (context, _) {
                  return AnimatedPositioned(
                      child: const Icon(
                        Icons.arrow_right_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                      top: ((game.size.y * 0.3 - 40) / 2) + game.size.y * 0.7 + 20,
                      right: arrowAnimationController.position,
                      duration: arrowAnimationController.animationDuration);
                },
              ),
            Positioned.fill(
              top: ((game.size.y * 0.3 - 40) / 2) + game.size.y * 0.7,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${state.bluePosition}'),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: Image.asset('assets/images/avatar_blue_s.png'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${state.redPosition}'),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: Image.asset('assets/images/avatar_red_s.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowAnimationController extends ChangeNotifier {
  _ArrowAnimationController({
    required this.startPosition,
    required this.endPosition,
    required this.animationDuration,
  }) : position = startPosition {
    start();
  }

  final double startPosition;
  final double endPosition;
  final Duration animationDuration;
  double position;
  bool _running = false;

  void stop() => _running = false;

  Future<void> start() async {
    _running = true;
    while (_running) {
      await Future.delayed(animationDuration);
      position = position == startPosition ? endPosition : startPosition;
      notifyListeners();
    }
  }
}
