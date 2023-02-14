import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/home/data/model/news/mock/news_response_model_mock.dart';
import 'package:news_app/home/data/model/news/news_response_model.dart';

void main() {
  test('NewsResponseModel should be able to convert from and to json',
      () async {
    // arrange
    final json = NewsResponseModelMock.mock.toMap();
    // act
    final news = NewsResponseModel.fromMap(json);
    // assert
    expect(news, NewsResponseModelMock.mock);
  });
}
