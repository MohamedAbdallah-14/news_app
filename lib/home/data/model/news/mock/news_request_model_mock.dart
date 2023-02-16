import 'package:news_app/home/data/model/news/news_request_model.dart';

class NewsRequestModelMock {
  static const pageMock = 1;
  static const limitMock = 1;

  static final mock = NewsRequestModel(
    page: pageMock,
    limit: limitMock,
  );
}
