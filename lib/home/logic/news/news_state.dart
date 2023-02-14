part of 'news_cubit.dart';

class NewsState extends Equatable {
  const NewsState({
    this.loading = false,
    this.failure,
    this.response,
  });

  final bool loading;
  final Failure? failure;
  final NewsResponseModel? response;

  NewsState requestSuccess(NewsResponseModel response) =>
      copyWith(loading: false, response: Nullable(response));

  NewsState requestFailed(Failure failure) =>
      copyWith(loading: false, failure: Nullable(failure));

  NewsState requestLoading() => copyWith(
        loading: true,
        failure: Nullable(null),
        response: Nullable(null),
      );

  NewsState copyWith({
    bool? loading,
    Nullable<Failure?>? failure,
    Nullable<NewsResponseModel?>? response,
  }) {
    return NewsState(
      loading: loading ?? this.loading,
      failure: failure == null ? this.failure : failure.value,
      response: response == null ? this.response : response.value,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        failure,
        response,
      ];

  @override
  bool get stringify => true;
}
