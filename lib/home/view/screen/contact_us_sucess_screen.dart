import 'package:flutter/material.dart';
import 'package:news_app/app/view/widgets/app_screen.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/view/widgets/custom_app_bar.dart';
import 'package:news_app/l10n/l10n.dart';

class ContactUsSuccessScreen extends StatelessWidget {
  const ContactUsSuccessScreen({
    required this.orderId,
    super.key,
  });

  final String orderId;
  static const id = '/contact-us-sucess';

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      appBar: const CustomAppBar(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.request_sent,
            style: const TextStyle(
              color: AppColors.darkBlueGrey,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${context.l10n.request_number}$orderId',
            style: const TextStyle(
              color: AppColors.battleshipGrey,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Assets.imagesSucess.image(width: 106),
        ],
      ),
    );
  }
}
