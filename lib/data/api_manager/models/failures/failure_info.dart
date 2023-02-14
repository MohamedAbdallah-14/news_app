import 'package:dio/dio.dart';
import 'package:news_app/data/api_manager/models/request/request.dart';

class FailureInfo {
  FailureInfo({
    this.request,
    this.response,
    this.exception,
  });
  final Request? request;
  final Response<dynamic>? response;
  final dynamic exception;
}
