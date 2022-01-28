part of 'alert_screen_store.dart';

class AlertScreenState extends Equatable {
  const AlertScreenState({
    required this.showSnakeMessage,
    required this.showLadderMessage,
    required this.showWinMessage,
    required this.showEndGameMessage,
  });

  final bool showSnakeMessage;
  final bool showLadderMessage;
  final bool showWinMessage;
  final bool showEndGameMessage;

  AlertScreenState copyWith({
    bool? showSnakeMessage,
    bool? showLadderMessage,
    bool? showWinMessage,
    bool? showEndGameMessage,
  }) =>
      AlertScreenState(
        showLadderMessage: showLadderMessage ?? this.showLadderMessage,
        showSnakeMessage: showSnakeMessage ?? this.showSnakeMessage,
        showWinMessage: showWinMessage ?? this.showWinMessage,
        showEndGameMessage: showEndGameMessage ?? this.showEndGameMessage,
      );

  @override
  List<Object?> get props => [showLadderMessage, showSnakeMessage, showWinMessage, showEndGameMessage];
}
