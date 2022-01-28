part of 'alert_screen_store.dart';

class AlertScreenState extends Equatable {
  const AlertScreenState({
    required this.showSnakeMessage,
    required this.showLadderMessage,
    required this.showWinMessage,
  });

  final bool showSnakeMessage;
  final bool showLadderMessage;
  final bool showWinMessage;

  AlertScreenState copyWith({
    bool? showSnakeMessage,
    bool? showLadderMessage,
    bool? showWinMessage,
  }) =>
      AlertScreenState(
        showLadderMessage: showLadderMessage ?? this.showLadderMessage,
        showSnakeMessage: showSnakeMessage ?? this.showSnakeMessage,
        showWinMessage: showWinMessage ?? this.showWinMessage,
      );

  @override
  List<Object?> get props => [showLadderMessage, showSnakeMessage, showWinMessage];
}
