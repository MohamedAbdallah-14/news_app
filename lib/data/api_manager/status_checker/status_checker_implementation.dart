import 'package:news_app/data/api_manager/status_checker/error_status.dart';
import 'package:news_app/data/api_manager/status_checker/http_codes.dart';

class StatusChecker {
  final success = [200, 201, 202, 204];
  final validationError = [400, 409, 422];
  final authorizationError = [401];
  final authenticationError = [403];
  final methodNotAllowedError = [405];
  final resourceNotFoundError = [404, 410];
  final invalidToken = [406];
  final timeout = [408];
  final serviceNotAvailable = [..._range(500, 599)];

  HTTPCodes call(int? statusCode) {
    final error = validationError +
        authorizationError +
        resourceNotFoundError +
        methodNotAllowedError +
        timeout;
    if (success.contains(statusCode)) return HTTPCodes.success;
    if (error.contains(statusCode)) return HTTPCodes.error;
    if (authenticationError.contains(statusCode)) return HTTPCodes.invalidToken;
    if (invalidToken.contains(statusCode)) return HTTPCodes.invalidToken;

    return serviceNotAvailable.contains(statusCode)
        ? HTTPCodes.serviceNotAvailable
        : HTTPCodes.unknown;
  }

  ErrorStatus getErrorState(int? statusCode) {
    if (validationError.contains(statusCode)) {
      return ErrorStatus.validationError;
    } else if (authorizationError.contains(statusCode)) {
      return ErrorStatus.authorizationError;
    } else if (authenticationError.contains(statusCode)) {
      return ErrorStatus.authenticationError;
    } else if (resourceNotFoundError.contains(statusCode)) {
      return ErrorStatus.resourceNotFoundError;
    } else if (methodNotAllowedError.contains(statusCode)) {
      return ErrorStatus.methodNotAllowedError;
    } else if (timeout.contains(statusCode)) {
      return ErrorStatus.timeoutError;
    }

    return ErrorStatus.unknownError;
  }
}

Iterable<int> _range(int from, int to) =>
    Iterable<int>.generate(to - from + 1, (i) => i + from);
