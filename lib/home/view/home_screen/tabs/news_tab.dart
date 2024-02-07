import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/helpers/generic_error_handler.dart';
import 'package:news_app/helpers/loader.dart';
import 'package:news_app/home/logic/home_cubit/home_cubit.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';
import 'package:news_app/home/view/home_screen/tabs/not_implemented_tab.dart';
import 'package:news_app/home/view/home_screen/tabs_enum.dart';
import 'package:news_app/home/view/home_screen/widgets/news_cell.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter <= 0) {
      context.read<NewsCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NewsCubit, NewsState>(
          listenWhen: (previous, current) =>
              previous.loading != current.loading,
          listener: (context, state) {
            state.loading
                ? Loader.instance.show(context)
                : Loader.instance.hide();
          },
        ),
        BlocListener<NewsCubit, NewsState>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure,
          listener: (context, state) {
            final failure = state.failure;
            if (failure != null) {
              GenericErrorHandler.instance.handle(
                failure: failure,
                onRetry: () => context.read<NewsCubit>().retry(),
                context: context,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          if (homeState.currentNewsTab == NewsTabs.images ||
              homeState.currentNewsTab == NewsTabs.videos) {
            return const NotImplementedTab();
          }

          return BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              final newsList = state.response?.news;

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  await context.read<NewsCubit>().reload();
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: newsList?.length ?? 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) => NewsCell(
                    newsModel: newsList![index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
