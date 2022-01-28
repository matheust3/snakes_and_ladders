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

  Future<void> showWinMessage(bool show) async {
    update(state.copyWith(showWinMessage: show));
    while (state.showWinMessage) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> showLadderMessage(bool show) async {
    update(state.copyWith(showLadderMessage: show));
    while (state.showLadderMessage) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
