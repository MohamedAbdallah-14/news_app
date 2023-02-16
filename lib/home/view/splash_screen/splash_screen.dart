import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/app_screen.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/helpers/generic_error_handler.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';
import 'package:news_app/home/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NewsCubit, NewsState>(
          listenWhen: (previous, current) =>
              previous.response != current.response && current.response != null,
          listener: (context, state) {
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          },
        ),
        BlocListener<NewsCubit, NewsState>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure && current.failure != null,
          listener: (context, state) {
            final failure = state.failure;
            GenericErrorHandler.instance.handle(
              failure: failure!,
              onRetry: () => context.read<NewsCubit>().retry(),
              context: context,
            );
          },
        ),
      ],
      child: AppScreen(
        backgroundColor: AppColors.darkBlueGrey,
        child: Center(
          child: Assets.imagesLogo.image(),
        ),
      ),
    );
  }
}
