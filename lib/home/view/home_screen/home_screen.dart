import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/app_screen.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/logic/home_cubit/home_cubit.dart';
import 'package:news_app/home/view/home_screen/tabs_enum.dart';
import 'package:news_app/home/view/widgets/custom_app_bar.dart';
import 'package:news_app/l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const id = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return AppScreen(
          appBar: const CustomAppBar(),
          bottomNavigationBar: buildNavigationBar(state, context),
          child: state.tabWidget,
        );
      },
    );
  }

  BottomNavigationBar buildNavigationBar(
    HomeState state,
    BuildContext context,
  ) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primary,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.blueGrey,
      currentIndex: state.currentTab.index,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      ),
      unselectedLabelStyle: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      ),
      items: [
        BottomNavigationBarItem(
          icon: itemIcon(NavigationTabs.home, state.currentTab),
          label: context.l10n.home,
        ),
        BottomNavigationBarItem(
          icon: itemIcon(NavigationTabs.table, state.currentTab),
          label: context.l10n.table,
        ),
        BottomNavigationBarItem(
          icon: itemIcon(NavigationTabs.news, state.currentTab),
          label: context.l10n.news,
        ),
        BottomNavigationBarItem(
          icon: itemIcon(NavigationTabs.statistics, state.currentTab),
          label: context.l10n.statistics,
        ),
        BottomNavigationBarItem(
          icon: itemIcon(NavigationTabs.more, state.currentTab),
          label: context.l10n.more,
        ),
      ],
      onTap: (index) => context.read<HomeCubit>().changeTab(
            NavigationTabs.values[index],
          ),
    );
  }

  Widget itemIcon(NavigationTabs tab, NavigationTabs currentTab) {
    String assetName;
    switch (tab) {
      case NavigationTabs.home:
        assetName = Assets.imagesNaviagtionHome.keyName;
        break;
      case NavigationTabs.table:
        assetName = Assets.imagesNaviagtionTable.keyName;
        break;
      case NavigationTabs.news:
        assetName = Assets.imagesNaviagtionNews.keyName;
        break;
      case NavigationTabs.statistics:
        assetName = Assets.imagesNaviagtionStar.keyName;
        break;
      case NavigationTabs.more:
        assetName = Assets.imagesNaviagtionMore.keyName;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Image.asset(
        assetName,
        width: 20,
        color: tab == currentTab ? AppColors.white : AppColors.blueGrey,
      ),
    );
  }
}
