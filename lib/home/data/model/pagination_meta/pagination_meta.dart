import 'package:equatable/equatable.dart';

class PaginationMeta extends Equatable {
  const PaginationMeta({
    required this.page,
    required this.count,
    required this.hasNextPage,
    this.nextPage,
  });

  factory PaginationMeta.fromMap(Map<String, dynamic> map) {
    final page = int.parse((map['page'] ?? '0').toString());
    final hasNextPage = map['hasNextPage'] as bool? ??
        (int.parse((map['pages'] ?? 0).toString()) > page);
    final nextPage =
        map['nextPage'] as int? ?? (hasNextPage ? (page + 1) : null);
    return PaginationMeta(
      page: page,
      count: int.parse((map['totalDocs'] ?? 0).toString()),
      hasNextPage: hasNextPage,
      nextPage: nextPage,
    );
  }

  final int page;
  final int count;
  final bool hasNextPage;
  final int? nextPage;

  Map<String, dynamic> toMap() => {
        'page': page,
        'count': count,
        'hasNextPage': hasNextPage,
        'nextPage': nextPage,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        page,
        count,
        hasNextPage,
        nextPage,
      ];
}
