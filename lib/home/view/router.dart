import 'package:flutter/material.dart';
import 'package:news_app/home/view/news_screen/news_screen.dart';
import 'package:news_app/home/view/splash/splash.dart';

class HomeRouter {
  HomeRouter._();
  static Route<Widget>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Splash.id:
        return MaterialPageRoute(
          builder: (_) => const Splash(),
          settings: routeSettings,
        );
      case NewsScreen.id:
        return MaterialPageRoute(
          builder: (_) => const NewsScreen(),
          settings: routeSettings,
        );
      default:
        return null;
    }
  }
}
