import 'package:flutter/material.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: AppColors.primary),
        Assets.imagesAppBarBackground.image(
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        SafeArea(
          child: Center(
            child: SizedBox(
              width: 60,
              height: 40,
              child: Assets.imagesLogo.image(),
            ),
          ),
        )
      ],
    );
  }
}
