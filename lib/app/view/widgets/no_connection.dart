import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/app/view/widgets/app_button.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/l10n/l10n.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({
    required this.failure,
    super.key,
    this.dismissible = true,
    this.retriable = true,
  });

  final bool retriable;
  final bool dismissible;
  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 12,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ColoredBox(
          color: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  if (Navigator.of(context, rootNavigator: true).canPop()) {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
                icon: const Icon(Icons.close, size: 18),
              ),
              if (retriable)
                Assets.imagesNoWifi.image(
                  height: 50,
                  color: AppColors.primary,
                  fit: BoxFit.cover,
                ),
              if (!retriable)
                Assets.imagesWarning.svg(
                  height: 50,
                  theme: const SvgTheme(currentColor: AppColors.primary),
                ),
              const SizedBox(height: 16),
              Text(
                retriable
                    ? context.l10n.no_connection
                    : context.l10n.try_again_later,
                style: const TextStyle(
                  color: AppColors.darkGreyBlue,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  retriable ? context.l10n.check_your_connection : '',
                  style: const TextStyle(
                    color: AppColors.darkGreyBlue,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25),
              if (dismissible && !retriable)
                AppButton(
                  key: const Key('no_connection_button_dismiss'),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  textKey: context.l10n.dismiss,
                  width: 125,
                  height: 35,
                  onPressed: () => dismiss(context: context, retry: false),
                ),
              if (!dismissible && retriable)
                AppButton(
                  key: const Key('no_connection_button_retry'),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  textKey: context.l10n.retry,
                  width: 125,
                  height: 35,
                  onPressed: () => dismiss(context: context, retry: true),
                ),
              if (dismissible && retriable)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: AppButton(
                        key: const Key('no_connection_button_dismiss'),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        textKey: context.l10n.dismiss,
                        mainButton: false,
                        height: 35,
                        onPressed: () =>
                            dismiss(context: context, retry: false),
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        key: const Key('no_connection_button_retry'),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        textKey: context.l10n.retry,
                        height: 35,
                        onPressed: () => dismiss(context: context, retry: true),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void dismiss({required BuildContext context, required bool retry}) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(retry);
    }
  }
}
