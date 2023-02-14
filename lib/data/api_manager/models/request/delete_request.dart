import 'package:news_app/data/api_manager/models/request/request.dart';
import 'package:news_app/data/api_manager/models/request_model.dart';

mixin DeleteRequest on Request {
  @override
  RequestModel get requestModel => EmptyRequestModel();

  @override
  Future<Map<String, dynamic>?> get queryParameters async {
    final map = await requestModel.toMap();

    return map.isEmpty ? null : requestModel.toMap();
  }

  @override
  Future<dynamic> get data async => null;

  @override
  String get method => 'DELETE';
}
