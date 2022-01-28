import 'package:equatable/equatable.dart';
import 'package:flutter_snakes_and_ladders/core/failures.dart';
import 'package:flutter_snakes_and_ladders/game/cobras_escadas.dart';
import 'package:flutter_snakes_and_ladders/overlays/roll_dice_screen/roll_dice_screen_store.dart';
import 'package:flutter_triple/flutter_triple.dart';

part 'game_ui_state.dart';

class GameUiStore extends NotifierStore<Failure, GameUiState> {
  GameUiStore({required this.rollDiceScreenStore})
      : super(const GameUiState(
          bluePosition: 0,
          isBlueTurn: true,
          redPosition: 0,
        ));

  final RollDiceScreenStore rollDiceScreenStore;
  late final CobrasEscadas _game;

  set game(CobrasEscadas g) => _game = g;

  void setBluePosition(int pos) => update(state.copyWith(bluePosition: pos));
  void setRedPosition(int pos) => update(state.copyWith(redPosition: pos));

  void setBlueTurn(bool turn) => update(state.copyWith(isBlueTurn: turn));

  Future<void> play() async {
    _game.overlays.add('roll_dices_screen');
    await rollDiceScreenStore.rollDices();
  }
}
