import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
import 'package:flutter_snakes_and_ladders/core/failures.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/game/cobras_escadas.dart';
import 'package:flutter_snakes_and_ladders/overlays/roll_dice_screen/roll_dice_screen_store.dart';
import 'package:flutter_triple/flutter_triple.dart';

part 'game_state.dart';

class GameStore extends NotifierStore<Failure, GameState> {
  GameStore() : super(const GameState(bluePlayerPosition: 0, movingAvatar: false, redPlayerPosition: 0, isBlueTurn: true));

  late final CobrasEscadas game;
  late final SpriteComponent avatarRed;
  late final SpriteComponent avatarBlue;

  void setBluePlayerPosition(int pos) => update(state.copyWith(bluePlayerPosition: pos));
  void setRedPlayerPosition(int pos) => update(state.copyWith(redPlayerPosition: pos));

  void setBlueTurn(bool v) => update(state.copyWith(isBlueTurn: v));
  void setMovingAvatar(bool moving) => update(state.copyWith(movingAvatar: moving));

  Future<void> play() async {
    final dice1 = sl<RollDiceScreenStore>().state.diceValue1;
    final dice2 = sl<RollDiceScreenStore>().state.diceValue2;
    game.jogar(dice1, dice2);
  }
}
