import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  const NewsModel({
    required this.id,
    required String titleAr,
    required String titleEn,
    required String contentAr,
    required String contentEn,
    required this.image,
    required this.createdAt,
  })  : _titleAr = titleAr,
        _titleEn = titleEn,
        _contentAr = contentAr,
        _contentEn = contentEn;

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
  final String _titleAr;
  final String _titleEn;
  final String _contentAr;
  final String _contentEn;
  final String image;
  final DateTime createdAt;

  String title({required bool ltr}) => ltr ? _titleEn : _titleAr;
  String content({required bool ltr}) => ltr ? _contentEn : _contentAr;

  Map<String, dynamic> toMap() => {
        'id': id,
        'title_ar': _titleAr,
        'title_en': _titleEn,
        'content_ar': _contentAr,
        'content_en': _contentEn,
        'image': image,
        'createdAt': createdAt.toString(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        _titleAr,
        _titleEn,
        _contentAr,
        _contentEn,
        image,
        createdAt,
      ];
}
