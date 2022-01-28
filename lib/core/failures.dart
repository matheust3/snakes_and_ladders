import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class GenericFailure extends Failure {
  const GenericFailure({required message}) : super(message: message);

  @override
  List<Object?> get props => [super.message];
}
