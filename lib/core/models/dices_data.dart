import 'package:equatable/equatable.dart';

class DicesData extends Equatable {
  const DicesData({required this.dice1, required this.dice2});

  final int dice1;
  final int dice2;

  DicesData copyWith({
    int? dice1,
    int? dice2,
  }) =>
      DicesData(dice1: dice1 ?? this.dice1, dice2: dice2 ?? this.dice2);

  @override
  List<Object?> get props => [dice1, dice2];
}
