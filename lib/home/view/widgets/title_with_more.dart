import 'package:flutter/material.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/l10n/l10n.dart';

class TitleWithMoreButton extends StatelessWidget {
  const TitleWithMoreButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(context.l10n.more),
          ),
        ],
      ),
    );
  }
}
