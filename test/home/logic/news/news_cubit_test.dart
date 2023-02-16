import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/news/mock/news_response_model_mock.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';

import '../../faker.dart';

void main() {
  late NewsCubit newsCubit;
  late MockHomeRepository repository;

  setUpAll(setupFaker);

  setUp(() {
    repository = MockHomeRepository();
    newsCubit = NewsCubit(repository);
  });

  test('Initial state loading should be false', () {
    expect(newsCubit.state, const NewsState());
  });

  blocTest<NewsCubit, NewsState>(
    '''
news should emit lodaing then emit succes when repository returns Right''',
    setUp: () {
      when(() => repository.news(any()))
          .thenAnswer((_) async => Right(NewsResponseModelMock.mock));
    },
    build: () => newsCubit,
    act: (NewsCubit cubit) => cubit.loadNextPage(),
    expect: () => [
      const NewsState(
        loading: true,
      ),
      NewsState(
        response: NewsResponseModelMock.mock,
        currentPage: 1,
      ),
    ],
  );

  blocTest<NewsCubit, NewsState>(
    '''
news should emit lodaing then emit failure when repository returns Left''',
    setUp: () {
      when(() => repository.news(any()))
          .thenAnswer((_) async => Left(ConnectionFailure()));
    },
    build: () => newsCubit,
    act: (NewsCubit cubit) => cubit.loadNextPage(),
    expect: () => [
      const NewsState(
        loading: true,
      ),
      NewsState(
        failure: ConnectionFailure(),
      ),
    ],
  );

  blocTest<NewsCubit, NewsState>(
    '''
Given current state is failure when news called and repository returns Right then emit loading true then false with success and no failure''',
    setUp: () {
      when(() => repository.news(any()))
          .thenAnswer((_) async => Right(NewsResponseModelMock.mock));
    },
    build: () => newsCubit,
    seed: () => NewsState(
      failure: ConnectionFailure(),
    ),
    act: (NewsCubit cubit) => cubit.loadNextPage(),
    expect: () => [
      const NewsState(
        loading: true,
      ),
      NewsState(
        response: NewsResponseModelMock.mock,
        currentPage: 1,
      ),
    ],
  );
}
