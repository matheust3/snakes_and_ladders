part of 'game_ui_store.dart';

class GameUiState extends Equatable {
  const GameUiState({required this.jogar});

  final Function(int dice1, int dice2)? jogar;

  @override
  List<Object?> get props => [jogar];
}
