import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/l10n/l10n.dart';

// ignore: strict_raw_type
Future<void> showAppModalBottomSheet<T extends Cubit>({
  required BuildContext context,
  required String titleKey,
  required List<Widget> widgetsList,
  String? messageKey,
  double percentOfScreenHeight = 0.6,
  VoidCallback? onDismiss,
  T? bloc,
}) {
  FocusScope.of(context).unfocus();
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (_) {
      if (bloc == null) {
        return _BottomSheet(
          context: context,
          titleKey: titleKey,
          messageKey: messageKey,
          widgetsList: widgetsList,
          percentOfScreenHeight: percentOfScreenHeight,
          onDismiss: onDismiss,
        );
      }
      return BlocProvider<T>.value(
        value: bloc,
        child: _BottomSheet(
          context: context,
          titleKey: titleKey,
          messageKey: messageKey,
          widgetsList: widgetsList,
          percentOfScreenHeight: percentOfScreenHeight,
          onDismiss: onDismiss,
        ),
      );
    },
  );
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    required this.context,
    required this.widgetsList,
    this.titleKey = '',
    this.messageKey,
    this.percentOfScreenHeight = 0.6,
    this.onDismiss,
  });

  final BuildContext context;
  final String titleKey;
  final String? messageKey;
  final List<Widget> widgetsList;
  final double percentOfScreenHeight;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  context.l10n.close,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                titleKey,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          if (messageKey != null) const SizedBox(height: 20),
          if (messageKey != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                messageKey!,
                style: const TextStyle(
                  color: AppColors.blueyGrey,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          if (messageKey != null) const SizedBox(height: 24),
          ConstrainedBox(
            constraints: BoxConstraints.loose(
              Size(
                double.infinity,
                MediaQuery.of(context).size.height * percentOfScreenHeight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(children: widgetsList),
            ),
          ),
        ],
      ),
    );
  }

  void dismiss({required BuildContext context}) {
    onDismiss?.call();
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
