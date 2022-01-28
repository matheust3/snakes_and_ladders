part of 'roll_dice_screen_store.dart';

class RollDiceScreenState extends Equatable {
  const RollDiceScreenState({required this.rollDices, required this.showDices, required this.diceValue1, required this.diceValue2});

  final bool rollDices;
  final bool showDices;
  final int diceValue1;
  final int diceValue2;

  RollDiceScreenState copyWith({
    bool? rollDices,
    bool? showDices,
    int? diceValue1,
    int? diceValue2,
  }) =>
      RollDiceScreenState(
        rollDices: rollDices ?? this.rollDices,
        showDices: showDices ?? this.showDices,
        diceValue1: diceValue1 ?? this.diceValue1,
        diceValue2: diceValue2 ?? this.diceValue2,
      );

  @override
  List<Object?> get props => [rollDices, showDices, diceValue1, diceValue2];
}
