import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/dependacy_injection/di.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/helpers/generic_error_handler.dart';
import 'package:news_app/helpers/loader.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';
import 'package:news_app/home/view/news_screen/widgets/news_cell.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  static const id = '/news-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => di<NewsCubit>(),
        child: const _Page(),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Loader.instance.show(context);
    //   context.read<NewsCubit>().loadNextPage();
    // });
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
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await context.read<NewsCubit>().reload();
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.response?.news.length ?? 0,
              itemBuilder: (context, index) => NewsCell(
                news: state.response?.news[index],
              ),
            ),
          );
        },
      ),
    );
  }

  void news(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<NewsCubit>().loadNextPage();
  }
}
