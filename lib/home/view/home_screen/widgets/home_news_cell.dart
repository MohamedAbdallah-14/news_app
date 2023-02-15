import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/image_loader.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/logic/news/news_cubit.dart';
import 'package:news_app/l10n/l10n.dart';

class HomeNewsCell extends StatelessWidget {
  const HomeNewsCell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      buildWhen: (previous, current) => previous.response != current.response,
      builder: (context, state) {
        final newsModel = state.response?.news.last;
        if (newsModel == null) {
          return Container();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageLoader(
                imageUrl: newsModel.image,
                width: MediaQuery.of(context).size.width,
                height: 178,
                logoWidth: 56,
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.sport_league,
                style: const TextStyle(
                  color: AppColors.brownishGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              Text(
                newsModel.titleAr,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        );
      },
    );
  }
}
