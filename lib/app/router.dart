import 'package:flutter/material.dart';
import 'package:news_app/home/view/router.dart';
import 'package:news_app/home/view/splash.dart';

class AppRouter {
  AppRouter._();
  static Route<Widget> onGenerateRoute(RouteSettings routeSettings) {
    return HomeRouter.onGenerateRoute(routeSettings) ??
        MaterialPageRoute(builder: (_) => const Splash());
  }
}
