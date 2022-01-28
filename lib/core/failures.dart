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

class CsvAdapterFailure extends Failure {
  const CsvAdapterFailure({required message}) : super(message: message);

  @override
  List<Object?> get props => [super.message];
}

class WebAdapterFailure extends Failure {
  const WebAdapterFailure({required String message}) : super(message: message);

  @override
  List<Object?> get props => [super.message];
}

class WebAdapterUnauthorizedFailure extends Failure {
  const WebAdapterUnauthorizedFailure() : super(message: 'User unauthorized');

  @override
  List<Object?> get props => [super.message];
}

class WebAdapterNoOkFailure extends Failure {
  final int statusCode;
  const WebAdapterNoOkFailure(this.statusCode) : super(message: 'StatusCode is not 200 OK');

  @override
  List<Object?> get props => [statusCode, super.message];
}

class NullArgumentFailure extends Failure {
  const NullArgumentFailure() : super(message: 'Null Argument');
  @override
  List<Object?> get props => [super.message];
}

class FilePickerFailure extends Failure {
  const FilePickerFailure({required String message}) : super(message: message);

  @override
  List<Object?> get props => [super.message];
}

class NullAreaInfo extends Failure {
  const NullAreaInfo() : super(message: 'AreaInfo from server is null');

  @override
  List<Object?> get props => [super.message];
}
