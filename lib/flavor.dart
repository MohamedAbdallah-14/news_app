import 'dart:io';

final testMode = Platform.environment.containsKey('FLUTTER_TEST');
bool get liveEnvironment => AppFlavor.instance.flavor == Flavor.mock;
bool get devEnvironment => AppFlavor.instance.flavor == Flavor.mock;
bool get mockEnvironment => AppFlavor.instance.flavor == Flavor.mock;

enum Flavor { dev, production, mock }

class AppFlavor {
  AppFlavor._();
  static final _instance = AppFlavor._();
  static AppFlavor get instance => _instance;

  Flavor flavor = Flavor.dev;

  String get baseUrl {
    switch (flavor) {
      case Flavor.production:
        return 'https://localhost/';
      case Flavor.dev:
        return 'https://localhost/';
      case Flavor.mock:
        return 'http://localhost/';
    }
  }
}
