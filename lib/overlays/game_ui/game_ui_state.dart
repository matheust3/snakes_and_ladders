part of 'game_ui_store.dart';

class GameUiState extends Equatable {
  const GameUiState({
    required this.isBlueTurn,
    required this.redPosition,
    required this.bluePosition,
  });

  final bool isBlueTurn;
  final int redPosition;
  final int bluePosition;

  GameUiState copyWith({
    bool? isBlueTurn,
    int? redPosition,
    int? bluePosition,
  }) =>
      GameUiState(
        isBlueTurn: isBlueTurn ?? this.isBlueTurn,
        redPosition: redPosition ?? this.redPosition,
        bluePosition: bluePosition ?? this.bluePosition,
      );

  @override
  List<Object?> get props => [isBlueTurn, redPosition, bluePosition];
}
