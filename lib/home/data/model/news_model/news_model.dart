import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  const NewsModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.contentAr,
    required this.contentEn,
    required this.image,
    required this.createdAt,
  });

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] as String,
      titleAr: map['title_ar'] as String,
      titleEn: map['title_en'] as String,
      contentAr: map['content_ar'] as String,
      contentEn: map['content_en'] as String,
      image: map['image'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  final String id;
  final String titleAr;
  final String titleEn;
  final String contentAr;
  final String contentEn;
  final String image;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'title_ar': titleAr,
        'title_en': titleEn,
        'content_ar': contentAr,
        'content_en': contentEn,
        'image': image,
        'createdAt': createdAt,
      };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        titleAr,
        titleEn,
        contentAr,
        contentEn,
        image,
        createdAt,
      ];
}
