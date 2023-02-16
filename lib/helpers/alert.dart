// ignore_for_file: unawaited_futures, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/helpers/loader.dart';
import 'package:news_app/l10n/l10n.dart';

class Alert {
  Alert._();

  Flushbar<dynamic>? current;

  static Alert _instance = Alert._();

  static Alert get instance => _instance;

  static void newInstance() => _instance = Alert._();

  void error(
    BuildContext context,
    String? message, {
    bool isNavigating = true,
  }) {
    if (isNavigating) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _showError(context, message));
    } else {
      _showError(context, message);
    }
  }

  Future<void> _showError(BuildContext context, String? message) async {
    await Loader.instance.waitForLoader.future;
    await current?.dismiss();
    current = Flushbar(
      title: context.l10n.error,
      message: (message?.isEmpty ?? true) ? 'some_thing_went_wrong' : message,
      backgroundColor: AppColors.deepRed,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: kDebugMode ? 3 : 3),
      animationDuration: const Duration(milliseconds: 500),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) current = null;
      },
    )..show(context);
  }

  void success(
    BuildContext context,
    String? message, {
    bool isNavigating = true,
  }) {
    if (isNavigating) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _showSuccess(context, message));
    } else {
      _showSuccess(context, message);
    }
  }

  Future<void> _showSuccess(BuildContext context, String? message) async {
    await Loader.instance.waitForLoader.future;
    await current?.dismiss();
    current = Flushbar(
      title: context.l10n.success,
      message: (message?.isEmpty ?? true) ? ' ' : message,
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: kDebugMode ? 1 : 3),
      animationDuration: const Duration(milliseconds: 500),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) current = null;
      },
    )..show(context);
  }
}
