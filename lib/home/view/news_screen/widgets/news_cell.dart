import 'package:flutter/material.dart';
import 'package:news_app/home/data/model/news_model/news_model.dart';

class NewsCell extends StatelessWidget {
  const NewsCell({
    required this.news,
    super.key,
  });

  final NewsModel? news;

  @override
  Widget build(BuildContext context) {
    if (news == null) return Container();
    return InkWell(
      onTap: () {},
      child: const Card(),
    );
  }
}
