import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:news_app/app/app.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/dependacy_injection/di.dart';
import 'package:news_app/flavor.dart';
import 'package:news_app/home/logic/language_cubit/language_cubit.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  BaseRequestDefaults.instance.baseUrl = AppFlavor.instance.baseUrl;
  initDependencyInjection();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LanguageCubit(),
          ),
          BlocProvider(
            create: (context) => di<NewsCubit>(),
          ),
        ],
        child: const App(),
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
