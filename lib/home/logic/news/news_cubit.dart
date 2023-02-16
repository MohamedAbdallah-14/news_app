import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/helpers/nullable.dart';
import 'package:news_app/home/data/home_repository.dart';
import 'package:news_app/home/data/model/news/news_request_model.dart';
import 'package:news_app/home/data/model/news/news_response_model.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._repository) : super(const NewsState());

  final HomeRepository _repository;
  RequestModel? requestModel;

  Future<void> _news({required int page}) async {
    final requestModel = NewsRequestModel(page: page, limit: 7);
    await __news(requestModel);
  }

  Future<void> __news(NewsRequestModel requestModel) async {
    this.requestModel = requestModel;
    emit(state.requestLoading());
    final result = await _repository.news(requestModel);
    emit(
      result.fold((failure) => state.requestFailed(failure), (response) {
        if (response.news.isEmpty) {
          return state.copyWith(lastPage: true, loading: false);
        }
        if (state.response != null) {
          final newItems = [...state.response!.news, ...response.news];
          response.news.clear();
          response.news.addAll(newItems);
        }
        return state.requestSuccess(
          response: response,
          currentPage: requestModel.page,
        );
      }),
    );
  }

  void retry() {
    if (requestModel is NewsRequestModel) {
      __news(requestModel! as NewsRequestModel);
    }
  }

  void loadNextPage() {
    if (state.loading || state.lastPage) return;

    _news(page: state.currentPage + 1);
  }

  Future<void> reload() async {
    emit(state.copyWith(response: Nullable(null)));
    await _news(page: 1);
  }
}
