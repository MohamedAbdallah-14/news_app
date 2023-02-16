import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException(this.response);
  final Response<dynamic>? response;

  @override
  List<Object?> get props => [response];
}
