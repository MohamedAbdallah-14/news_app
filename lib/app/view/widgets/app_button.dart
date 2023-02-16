import 'package:flutter/material.dart';
import 'package:news_app/helpers/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.textKey,
    required this.onPressed,
    super.key,
    this.height,
    this.width,
    this.mainButton = true,
    this.margin,
    this.child,
    this.backgroundColor,
    this.color,
    this.isLoading = false,
  });

  final String textKey;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool mainButton;
  final Color? backgroundColor;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Container(
      width: width ?? double.infinity,
      margin: margin ?? EdgeInsets.zero,
      height: height ?? 50,
      decoration: mainButton
          ? null
          : BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: onPressed == null
                    ? AppColors.brownishGrey
                    : color ?? AppColors.primary,
              ),
            ),
      child: MaterialButton(
        color: backgroundColor ??
            (mainButton ? color ?? AppColors.primary : AppColors.white),
        onPressed: onPressed,
        disabledColor: mainButton ? AppColors.brownishGrey : AppColors.paleGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: AppColors.white,
              )
            : child ??
                Text(
                  textKey,
                  style: mainButton
                      ? const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          fontSize: 14,
                        )
                      : TextStyle(
                          color: color ?? AppColors.primary,
                          fontWeight: FontWeight.w700,
                          height: 1,
                          fontSize: 17,
                        ),
                ),
      ),
    );
  }
}
