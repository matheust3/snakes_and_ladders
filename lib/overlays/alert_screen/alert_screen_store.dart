import 'package:equatable/equatable.dart';
import 'package:flutter_snakes_and_ladders/core/failures.dart';
import 'package:flutter_triple/flutter_triple.dart';

part 'alert_screen_state.dart';

class AlertScreenStore extends NotifierStore<Failure, AlertScreenState> {
  AlertScreenStore()
      : super(const AlertScreenState(
          showSnakeMessage: false,
          showLadderMessage: false,
          showWinMessage: false,
        ));

  Future<void> showSnakeMessage(bool show) async {
    update(state.copyWith(showSnakeMessage: show));
    while (state.showSnakeMessage) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
