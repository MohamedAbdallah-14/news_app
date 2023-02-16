import 'package:news_app/data/api_manager/models/request_model.dart';

abstract class BaseRequest {
  BaseRequest(
    this.path,
    this.method,
    this.queryParameters,
    this.requestModel,
    this.data,
  );

  final RequestModel requestModel;
  final String path;
  final String method;
  final Future<Map<String, dynamic>?> queryParameters;
  final Future<dynamic> data;
}
