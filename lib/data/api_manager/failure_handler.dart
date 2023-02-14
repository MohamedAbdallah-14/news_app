import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/data/api_manager/models/exceptions/error_exception.dart';
import 'package:news_app/data/api_manager/models/exceptions/server_exception.dart';
import 'package:news_app/data/api_manager/models/exceptions/validation_exception.dart';
import 'package:news_app/data/api_manager/models/failures/connection_failure.dart';
import 'package:news_app/data/api_manager/models/failures/error_failure.dart';
import 'package:news_app/data/api_manager/models/failures/failure.dart';
import 'package:news_app/data/api_manager/models/failures/failure_info.dart';
import 'package:news_app/data/api_manager/models/failures/request_canceled_failure.dart';
import 'package:news_app/data/api_manager/models/failures/service_not_available_failure.dart';
import 'package:news_app/data/api_manager/models/failures/session_ended_failure.dart';
import 'package:news_app/data/api_manager/models/failures/type_failure.dart';
import 'package:news_app/data/api_manager/models/failures/unkown_failure.dart';
import 'package:news_app/data/api_manager/models/failures/validation_failure.dart';
import 'package:news_app/data/api_manager/models/request/request_mixin.dart';
import 'package:news_app/data/api_manager/status_checker/http_codes.dart';
import 'package:news_app/data/api_manager/status_checker/status_checker_implementation.dart';

class FailureHandler {
  FailureHandler();
  final StatusChecker _statusChecker = StatusChecker();

  Failure handle({
    Request? request,
    dynamic exception,
    Response<dynamic>? response,
  }) {
    final failureInfo = FailureInfo(
      request: request,
      exception: exception,
      response: response,
    );
    Failure? failure;
    if (exception is ErrorException) {
      failure = ErrorFailure(
        errorStatus: _statusChecker.getErrorState(exception.statusCode),
        error: exception.error,
      );
    } else if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          failure = ConnectionFailure();
          break;
        case DioErrorType.cancel:
          failure = RequestCanceledFailure();
          break;
        case DioErrorType.response:
        case DioErrorType.other:
          {
            final socketException =
                exception.message.contains('SocketException');
            final getRequest = request?.method == 'GET';
            final httpException = exception.message.contains('HttpException') ||
                exception.message.contains('Connection');
            failure = socketException || (httpException && getRequest)
                ? ConnectionFailure()
                : UnkownFailure(failureInfo);
          }
      }
    } else if (exception is ServerException) {
      final status = _statusChecker(exception.response?.statusCode);
      switch (status) {
        case HTTPCodes.invalidToken:
          failure = SessionEndedFailure();
          break;
        case HTTPCodes.serviceNotAvailable:
          failure = ServiceNotAvailableFailure(failureInfo);
          break;
        case HTTPCodes.unknown:
          failure = UnkownFailure(failureInfo);
          break;
        case HTTPCodes.success:
        case HTTPCodes.error:
          break;
      }
    } else if (exception is SocketException) {
      failure = ConnectionFailure();
    } else if (exception is FormatException ||
        exception is RangeError ||
        exception is TypeError ||
        exception is NoSuchMethodError) {
      failure = TypeFailure(failureInfo);
    } else if (exception is ValidationException) {
      failure = ValidationFailure(exception.value);
    }

    return failure ?? UnkownFailure(failureInfo);
  }
}
