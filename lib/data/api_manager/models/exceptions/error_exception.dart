import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/models/response_model.dart';

class ErrorException extends Equatable implements Exception {
  const ErrorException(this.statusCode, this.error);
  final int statusCode;
  final ResponseModel error;

  @override
  List<Object?> get props => [statusCode, error];
}
