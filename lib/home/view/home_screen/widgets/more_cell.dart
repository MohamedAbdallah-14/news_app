import 'package:flutter/material.dart';
import 'package:news_app/helpers/alert.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/l10n/l10n.dart';

class MoreCell extends StatelessWidget {
  const MoreCell({
    required this.title,
    required this.color,
    this.onPressed,
    super.key,
  });

  final String title;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ??
          () => Alert.instance.error(context, context.l10n.not_implemented),
      child: Container(
        height: 35,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 2,
              height: 35,
              margin: const EdgeInsetsDirectional.only(end: 16),
              color: color,
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.veryLightPink,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
