import '../pagination_meta.dart';

class PaginationMetaMock {
//*this return the !same! instance every time it's called
  static const mock = PaginationMeta(
    page: 1,
    count: 100,
    hasNextPage: false,
    
  );
}
