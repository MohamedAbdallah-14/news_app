import 'package:dartz/dartz.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/flavor.dart';
import 'package:news_app/home/data/model/news/mock/news_response_model_mock.dart';
import 'package:news_app/home/data/model/news/news_request_model.dart';
import 'package:news_app/home/data/model/news/news_response_model.dart';
import 'package:news_app/home/data/request/news_request.dart';

class HomeRepository {
  HomeRepository(this._apIsManager);

  final APIsManager _apIsManager;

  Future<Either<Failure, NewsResponseModel>> news(
    NewsRequestModel requestModel,
  ) async {
    if (mockEnvironment) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return Right(
        testMode ? NewsResponseModelMock.mock : NewsResponseModelMock.random,
      );
    } else {
      final response = await _apIsManager.send(
        request: NewsRequest(requestModel),
        responseFromMap: NewsResponseModel.fromMap,
      );
      return response;
    }
  }
}
