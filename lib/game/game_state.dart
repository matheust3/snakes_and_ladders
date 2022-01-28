part of 'game_store.dart';

class GameState extends Equatable {
  const GameState({
    required this.bluePlayerPosition,
    required this.redPlayerPosition,
    required this.isBlueTurn,
  });

  final int redPlayerPosition;
  final int bluePlayerPosition;
  final bool isBlueTurn;

  GameState copyWith({
    int? redPlayerPosition,
    int? bluePlayerPosition,
    bool? isBlueTurn,
  }) =>
      GameState(
          bluePlayerPosition: bluePlayerPosition ?? this.bluePlayerPosition,
          redPlayerPosition: redPlayerPosition ?? this.redPlayerPosition,
          isBlueTurn: isBlueTurn ?? this.isBlueTurn);

  @override
  List<Object?> get props => [redPlayerPosition, bluePlayerPosition, isBlueTurn];
}
