import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';
import 'package:news_app/home/view/home_screen/widgets/news_cell.dart';
import 'package:news_app/l10n/l10n.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      buildWhen: (previous, current) => previous.response != current.response,
      builder: (context, state) {
        final newsList = state.response?.news;
        if (newsList == null || newsList.isEmpty) {
          return Center(
            child: Text(
              context.l10n.not_implemented,
            ),
          );
        }
        return ListView.builder(
          itemCount: newsList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) => NewsCell(
            newsModel: newsList[index],
          ),
        );
      },
    );
  }
}
