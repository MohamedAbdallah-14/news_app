import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/news/news_request_model.dart';

class NewsRequest with Request, GetRequest {
  const NewsRequest(this.requestModel);

  @override
  final NewsRequestModel requestModel;

  @override
  String get path => 'news';
}
