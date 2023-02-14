import 'package:get_it/get_it.dart';
import 'package:news_app/home/data/home_repository.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';

class HomeDI {
  HomeDI(this.di, {HomeRepository? repository}) {
    call(repository);
  }

  final GetIt di;

  void call(HomeRepository? repository) {
    di
      ..registerFactory(() => NewsCubit(di()))
      ..registerFactory(
        () => repository ?? HomeRepository(di()),
      );
  }
}
