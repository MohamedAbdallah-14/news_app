import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/home/data/model/news_model/mock/news_model_mock.dart';
import 'package:news_app/home/data/model/news_model/news_model.dart';

void main() {
  test('NewsModel should be able to convert from and to json', () async {
    // arrange
    final json = NewsModelMock.mock.toMap();
    // act
    final newsModel = NewsModel.fromMap(json);
    // assert
    expect(newsModel, NewsModelMock.mock);
  });
}
