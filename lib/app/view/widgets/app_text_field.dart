import 'package:flutter/material.dart';
import 'package:news_app/helpers/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintKey,
    this.labelKey,
    this.subLabel,
    this.validator,
    this.onChanged,
    this.textInputType,
    this.initialValue,
    this.textInputAction,
    this.onFieldSubmitted,
    this.margin,
    this.suffixIcon,
    this.prefixIcon,
    this.userInput = true,
    this.onUserTap,
    this.maxLines,
    this.fillColor,
    this.focusNode,
    this.isDense,
    this.textDirection,
  });

  final TextEditingController? controller;
  final String? hintKey;
  final String? labelKey;
  final String? subLabel;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final void Function(String value)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsets? margin;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool userInput;
  final GestureTapCallback? onUserTap;
  final int? maxLines;
  final Color? fillColor;
  final FocusNode? focusNode;
  final bool? isDense;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelKey != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    labelKey ?? '',
                    style: const TextStyle(
                      color: AppColors.darkBlueGrey,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                if (subLabel != null) const SizedBox(width: 4),
                if (subLabel != null)
                  Expanded(
                    child: Text(
                      subLabel ?? '',
                      style: const TextStyle(
                        color: AppColors.pinkishGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
              ],
            ),
          ),
        GestureDetector(
          onTap: onUserTap,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.transparent,
            ),
            margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: AppColors.brownishGrey,
              ),
              child: TextFormField(
                textDirection: textDirection,
                focusNode: focusNode,
                controller: controller,
                maxLines: maxLines,
                keyboardType: (maxLines ?? 0) > 1
                    ? TextInputType.multiline
                    : textInputType,
                enabled: userInput,
                initialValue: initialValue,
                validator: validator,
                onChanged: onChanged,
                cursorColor: AppColors.primary,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  prefixIconConstraints:
                      const BoxConstraints(minHeight: 16, minWidth: 46),
                  prefixIcon: prefixIcon,
                  contentPadding: isDense == null
                      ? const EdgeInsets.symmetric(horizontal: 16, vertical: 18)
                      : const EdgeInsets.all(8),
                  suffixIcon: suffixIcon,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.veryLightPink),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.veryLightPink),
                  ),
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.veryLightPink),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.deepRed),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.deepRed),
                  ),
                  errorStyle: const TextStyle(
                    color: AppColors.deepRed,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                  hintText: hintKey,
                  hintTextDirection: textDirection,
                  fillColor: fillColor ?? Colors.transparent,
                  filled: true,
                  alignLabelWithHint: true,
                  isDense: isDense,
                ),
                textInputAction: textInputAction ?? TextInputAction.next,
                onFieldSubmitted: onFieldSubmitted,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
