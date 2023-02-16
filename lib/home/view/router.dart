import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/data/model/news_model/news_model.dart';
import 'package:news_app/home/logic/home_cubit/home_cubit.dart';
import 'package:news_app/home/view/home_screen/home_screen.dart';
import 'package:news_app/home/view/news_screen/news_screen.dart';
import 'package:news_app/home/view/screen/contact_us_screen.dart';
import 'package:news_app/home/view/screen/contact_us_sucess_screen.dart';
import 'package:news_app/home/view/splash_screen/splash_screen.dart';

class HomeRouter {
  HomeRouter._();
  static Route<Widget>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: routeSettings,
        );
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(),
            child: const HomeScreen(),
          ),
          settings: routeSettings,
        );
      case NewsScreen.id:
        return MaterialPageRoute(
          builder: (_) => NewsScreen(
            newsModel: routeSettings.arguments! as NewsModel,
          ),
          settings: routeSettings,
        );
      case ContactUsScreen.id:
        return MaterialPageRoute(
          builder: (_) => const ContactUsScreen(),
          settings: routeSettings,
        );
      case ContactUsSuccessScreen.id:
        return MaterialPageRoute(
          builder: (_) => ContactUsSuccessScreen(
            orderId: routeSettings.arguments! as String,
          ),
          settings: routeSettings,
        );
      default:
        return null;
    }
  }
}
