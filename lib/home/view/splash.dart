import 'package:flutter/material.dart';
import 'package:news_app/app/view/widgets/app_screen.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AppScreen(
      backgroundColor: AppColors.darkBlueGrey,
      child: Center(
        child: Assets.imagesLogo.image(),
      ),
    );
  }
}
