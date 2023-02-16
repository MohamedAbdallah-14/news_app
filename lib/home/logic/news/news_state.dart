part of 'news_cubit.dart';

class NewsState extends Equatable {
  const NewsState({
    this.loading = false,
    this.failure,
    this.response,
    this.currentPage = 0,
    this.lastPage = false,
  });

  final bool loading;
  final Failure? failure;
  final NewsResponseModel? response;
  final int currentPage;
  final bool lastPage;

  NewsState requestSuccess({
    required NewsResponseModel response,
    required int currentPage,
  }) =>
      copyWith(
        loading: false,
        response: Nullable(response),
        currentPage: currentPage,
        lastPage: response.news.isEmpty,
      );

  NewsState requestFailed(Failure failure) => copyWith(
        loading: false,
        failure: Nullable(failure),
      );

  NewsState requestLoading() => copyWith(
        loading: true,
        failure: Nullable(null),
      );

  NewsState copyWith({
    bool? loading,
    Nullable<Failure?>? failure,
    Nullable<NewsResponseModel?>? response,
    int? currentPage,
    bool? lastPage,
  }) {
    return NewsState(
      loading: loading ?? this.loading,
      failure: failure == null ? this.failure : failure.value,
      response: response == null ? this.response : response.value,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        failure,
        response,
        currentPage,
        lastPage,
      ];

  @override
  bool get stringify => true;
}
