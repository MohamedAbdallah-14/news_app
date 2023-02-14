import 'package:equatable/equatable.dart';

class ValidationException extends Equatable implements Exception {
  const ValidationException(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}
