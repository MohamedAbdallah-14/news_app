import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/news_model/news_model.dart';

class NewsResponseModel extends Equatable implements ResponseModel {
  const NewsResponseModel({
    required this.news,
  });

  factory NewsResponseModel.fromMap(Map<String, dynamic> map) {
    return NewsResponseModel(
      news: List<NewsModel>.from(
        ((map['list'] ?? <dynamic>[]) as List<dynamic>).map(
          (e) => NewsModel.fromMap(
            e as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }

  final List<NewsModel> news;

  Map<String, dynamic> toMap() => {
        'list': news.map((x) => x.toMap()).toList(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [news];
}
