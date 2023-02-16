import 'package:news_app/data/api_manager/api_manager.dart';

class NewsRequestModel extends RequestModel {
  NewsRequestModel({
    required this.page,
    required this.limit,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  final int page;
  final int limit;

  @override
  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    return map;
  }

  @override
  List<Object> get props => [
        page,
        limit,
      ];
}
