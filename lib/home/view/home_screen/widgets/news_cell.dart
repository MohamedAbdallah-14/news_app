import 'package:flutter/material.dart';
import 'package:news_app/app/view/widgets/image_loader.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/data/model/news_model/news_model.dart';
import 'package:news_app/home/logic/language_cubit/language_cubit.dart';
import 'package:news_app/home/view/news_screen/news_screen.dart';
import 'package:news_app/l10n/l10n.dart';

class NewsCell extends StatelessWidget {
  const NewsCell({
    required this.newsModel,
    super.key,
  });

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        NewsScreen.id,
        arguments: newsModel,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 94,
        child: Row(
          children: [
            ImageLoader(
              imageUrl: newsModel.image,
              width: 120,
              height: 94,
              logoWidth: 34,
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width - 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.sport_league,
                    style: const TextStyle(
                      color: AppColors.brownishGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    newsModel.title(ltr: ltr),
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    newsModel.createdAt.toString(),
                    style: const TextStyle(
                      color: AppColors.brownishGrey,
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
    );
  }
}
