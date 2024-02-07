import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/logic/home_cubit/home_cubit.dart';
import 'package:news_app/home/view/home_screen/tabs_enum.dart';
import 'package:news_app/l10n/l10n.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.showTabBr = false,
    super.key,
  });

  final bool showTabBr;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        children: [
          Container(color: AppColors.primary),
          Assets.imagesAppBarBackground.image(
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: SizedBox(
                width: 60,
                height: 40,
                child: Assets.imagesLogo.image(),
              ),
            ),
          ),
          if (Navigator.canPop(context))
            SafeArea(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          if (showTabBr)
            SafeArea(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: TabBar(
                  indicatorColor: AppColors.white,
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.greyblue,
                  onTap: (index) {
                    context
                        .read<HomeCubit>()
                        .changeNewsTab(NewsTabs.values[index]);
                  },
                  tabs: [
                    Tab(text: context.l10n.news),
                    Tab(text: context.l10n.images),
                    Tab(text: context.l10n.videos),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
