import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:news_app/flavor.dart';

bool get shouldLog =>
    AppFlavor.instance.flavor != Flavor.production || kDebugMode;

class AppLogger {
  AppLogger._();
  static final _instance = AppLogger._();
  static AppLogger get instance => _instance;
  final _logger = Logger();

  void log(
    String message, {
    LogLevel? logLevel,
    StackTrace? stackTrace,
  }) {
    if (shouldLog) {
      _logger.log(
        logLevel.toLevel(),
        message,
        stackTrace,
      );
    }
  }
}

enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  nothing,
}

extension LogLevelExtention on LogLevel? {
  Level toLevel() {
    switch (this) {
      case null:
      case LogLevel.verbose:
        return Level.verbose;
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.info:
        return Level.info;
      case LogLevel.warning:
        return Level.warning;
      case LogLevel.error:
        return Level.error;
      case LogLevel.nothing:
        return Level.nothing;
    }
  }
}
