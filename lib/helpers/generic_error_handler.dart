// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/no_connection.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/helpers/loader.dart';

class GenericErrorHandler {
  GenericErrorHandler._();

  bool isShowing = false;

  static final GenericErrorHandler _instance = GenericErrorHandler._();

  static GenericErrorHandler get instance => _instance;

  Future<void> handle<T extends Bloc>({
    required BuildContext context,
    required Failure failure,
    dynamic event,
    Function? onRetry,
    bool dismissible = true,
  }) async {
    assert(
      (onRetry == null) ^ (event == null),
      'Must provide either onRetry or an event',
    );
    await Loader.instance.waitForLoader.future;
    var retriable = false;
    if (context.mounted) FocusScope.of(context).unfocus();
    if (failure is ConnectionFailure) retriable = true;
    if (isShowing) return;
    isShowing = true;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final retry = await showDialog<bool>(
              context: context,
              barrierDismissible: dismissible,
              builder: (context) => NoConnection(
                dismissible: dismissible,
                retriable: retriable,
                failure: failure,
              ),
            ) ??
            false;
        isShowing = false;
        if (retry) {
          if (onRetry == null) {
            if (context.mounted) context.read<T>().add(event);
          } else {
            // ignore: avoid_dynamic_calls
            onRetry();
          }
        }
      },
    );
  }
}
