import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/flavor.dart';
import 'package:news_app/home/data/home_repository.dart';
import 'package:news_app/home/data/model/news/mock/news_request_model_mock.dart';
import 'package:news_app/home/data/model/news/mock/news_response_model_mock.dart';
import 'package:news_app/home/data/model/news/news_response_model.dart';

import '../faker.dart';

void main() {
  late HomeRepository repository;
  late MockAPIsManager apIsManager;

  setUpAll(setupFaker);

  setUp(() {
    AppFlavor.instance.flavor = Flavor.dev;
    apIsManager = MockAPIsManager();
    repository = HomeRepository(apIsManager);
  });

  group('News', () {
    test('''
should return Right(NewsResponseModel) when data apimanger return valid data ''',
        () async {
      // arrange
      when(
        () => apIsManager.send<NewsResponseModel, MessageResponseModel>(
          request: any(named: 'request'),
          responseFromMap: any(named: 'responseFromMap'),
        ),
      ).thenAnswer((_) async => Right(NewsResponseModelMock.mock));
      // act
      final result = await repository.news(NewsRequestModelMock.mock);
      // assert
      expect(
        result,
        Right<dynamic, NewsResponseModel>(
          NewsResponseModelMock.mock,
        ),
      );
    });

    test('''
should return Left(ValidationError, MessageResponseModel) when data apimanger return invalid data ''',
        () async {
      // arrange
      final failure = ErrorFailure(
        errorStatus: ErrorStatus.validationError,
        error: MessageResponseModel(message: 'error'),
      );
      when(
        () => apIsManager.send<NewsResponseModel, MessageResponseModel>(
          request: any(named: 'request'),
          responseFromMap: any(named: 'responseFromMap'),
        ),
      ).thenAnswer((_) async => Left(failure));
      // act
      final result = await repository.news(NewsRequestModelMock.mock);
      // assert
      expect(result, Left<ErrorFailure, dynamic>(failure));
    });

    test('''
should return Left(ServiceNotAvailableFailure) when data apimanger throws server exception''',
        () async {
      // arrange
      when(
        () => apIsManager.send<NewsResponseModel, MessageResponseModel>(
          request: any(named: 'request'),
          responseFromMap: any(named: 'responseFromMap'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServiceNotAvailableFailure(
            FailureInfo(),
          ),
        ),
      );
      // act
      final result = await repository.news(NewsRequestModelMock.mock);
      dynamic value;
      result.fold((l) => value = l, (r) => value = r);
      // assert
      expect(value, isA<ServiceNotAvailableFailure>());
    });
  });

  group('Mock Repository', () {
    setUp(() {
      AppFlavor.instance.flavor = Flavor.mock;
    });

    test('Should return NewsResponseModel when news called', () async {
      final response = await repository.news(NewsRequestModelMock.mock);
      expect(
        response,
        Right<dynamic, NewsResponseModel>(NewsResponseModelMock.mock),
      );
    });
  });
}
