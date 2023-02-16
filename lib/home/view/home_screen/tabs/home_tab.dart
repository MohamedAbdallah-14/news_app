import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/logic/home_cubit/home_cubit.dart';
import 'package:news_app/home/view/home_screen/tabs_enum.dart';
import 'package:news_app/home/view/home_screen/widgets/home_news_cell.dart';
import 'package:news_app/home/view/widgets/title_with_more.dart';
import 'package:news_app/l10n/l10n.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TitleWithMoreButton(
            title: context.l10n.latest_news,
            onPressed: () {
              context.read<HomeCubit>().changeTab(NavigationTabs.news);
            },
          ),
          const HomeNewsCell(),
        ],
      ),
    );
  }
}
