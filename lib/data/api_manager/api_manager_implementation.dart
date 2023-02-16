import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/data/api_manager/failure_handler.dart';
import 'package:news_app/data/api_manager/models/exceptions/error_exception.dart';
import 'package:news_app/data/api_manager/models/exceptions/server_exception.dart';
import 'package:news_app/data/api_manager/models/failures/failure.dart';
import 'package:news_app/data/api_manager/models/message_response_model.dart';
import 'package:news_app/data/api_manager/models/request/request_mixin.dart';
import 'package:news_app/data/api_manager/models/response_model.dart';
import 'package:news_app/data/api_manager/status_checker/http_codes.dart';
import 'package:news_app/data/api_manager/status_checker/status_checker_implementation.dart';
import 'package:news_app/helpers/app_logger.dart';
import 'package:news_app/helpers/dio2curl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIsManager {
  APIsManager({
    this.interceptors = const [],
  }) {
    if (shouldLog) {
      _dio.interceptors.addAll(interceptors);
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }
  final StatusChecker _statusChecker = StatusChecker();
  final FailureHandler _failureHandler = FailureHandler();
  final Dio _dio = Dio();
  final List<Interceptor> interceptors;

  Future<Either<Failure, R>> send<R, ER extends ResponseModel>({
    required Request request,
    required R Function(Map<String, dynamic> map) responseFromMap,
    ER Function(Map<String, dynamic> map)? errorResponseFromMap,
  }) async {
    Response<dynamic>? response;
    try {
      response = await _dio.request(
        request.url,
        data: await request.data,
        queryParameters: await request.queryParameters,
        cancelToken: request.cancelToken,
        onSendProgress: request.requestModel.progressListener?.onSendProgress,
        onReceiveProgress:
            request.requestModel.progressListener?.onReceiveProgress,
        options: Options(
          headers: request.headers,
          method: request.method,
        ),
      );
      dio2curl(response.requestOptions);
      if (response.data! is Map<String, dynamic>) {
        return Right(responseFromMap(response.data as Map<String, dynamic>));
      } else if (response.data is String) {
        return Right(responseFromMap({'msg': response.data}));
      } else if (response.data is List && (response.data as List).isNotEmpty) {
        return Right(responseFromMap({'list': response.data}));
      } else {
        return Right(responseFromMap({'msg': response.data.toString()}));
      }
    } on DioError catch (error) {
      dio2curl(error.response?.requestOptions);
      if (error.type == DioErrorType.response) {
        if (error.response?.statusCode != null &&
            _statusChecker(error.response!.statusCode) == HTTPCodes.error) {
          try {
            var errorData = <String, dynamic>{};
            errorData = error.response!.data is Map<String, dynamic>
                ? error.response!.data as Map<String, dynamic>
                : {'msg': error.response!.data};
            final exception = ErrorException(
              error.response!.statusCode!,
              errorResponseFromMap != null
                  ? errorResponseFromMap(errorData)
                  : MessageResponseModel.fromMap(errorData),
            );

            return Left(
              _failureHandler.handle(
                request: request,
                exception: exception,
                response: error.response,
              ),
            );
          } catch (exception) {
            return Left(
              _failureHandler.handle(
                request: request,
                exception: exception,
                response: response,
              ),
            );
          }
        } else {
          final exception = ServerException(error.response);

          return Left(
            _failureHandler.handle(
              request: request,
              exception: exception,
              response: error.response,
            ),
          );
        }
      }

      return Left(
        _failureHandler.handle(
          request: request,
          exception: error,
          response: error.response,
        ),
      );
    } catch (exception) {
      dio2curl(response?.requestOptions);

      return Left(
        _failureHandler.handle(
          request: request,
          exception: exception,
          response: response,
        ),
      );
    }
  }
}
