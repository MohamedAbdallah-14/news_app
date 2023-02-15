import 'package:flutter/material.dart';
import 'package:news_app/app/view/widgets/app_screen.dart';
import 'package:news_app/app/view/widgets/image_loader.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/alert.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/data/model/news_model/news_model.dart';
import 'package:news_app/home/logic/language_cubit/language_cubit.dart';
import 'package:news_app/l10n/l10n.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({
    required this.newsModel,
    super.key,
  });

  final NewsModel newsModel;

  static const id = '/news-screen';

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 280,
            floating: true,
            pinned: true,
            title: Assets.imagesLogo.image(width: 40),
            centerTitle: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: ImageLoader(
                imageUrl: newsModel.image,
                height: 400,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Alert.instance.error(context, context.l10n.not_implemented);
                },
                icon: const Icon(Icons.share),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsModel.title(ltr: ltr),
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.l10n.sport_league,
                        style: const TextStyle(
                          color: AppColors.brownishGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        newsModel.createdAt.toString(),
                        style: const TextStyle(
                          color: AppColors.brownishGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        newsModel.content(ltr: ltr),
                        style: const TextStyle(
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
