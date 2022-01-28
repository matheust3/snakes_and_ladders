part of 'game_store.dart';

class GameState extends Equatable {
  const GameState({
    required this.bluePlayerPosition,
    required this.redPlayerPosition,
    required this.isBlueTurn,
    required this.movingAvatar,
  });

  final int redPlayerPosition;
  final int bluePlayerPosition;
  final bool isBlueTurn;
  final bool movingAvatar;

  GameState copyWith({
    int? redPlayerPosition,
    int? bluePlayerPosition,
    bool? isBlueTurn,
    bool? movingAvatar,
  }) =>
      GameState(
        bluePlayerPosition: bluePlayerPosition ?? this.bluePlayerPosition,
        redPlayerPosition: redPlayerPosition ?? this.redPlayerPosition,
        isBlueTurn: isBlueTurn ?? this.isBlueTurn,
        movingAvatar: movingAvatar ?? this.movingAvatar,
      );

  @override
  List<Object?> get props => [redPlayerPosition, bluePlayerPosition, isBlueTurn, movingAvatar];
}
