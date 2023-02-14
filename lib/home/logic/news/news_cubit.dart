import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/home_repository.dart';
import 'package:news_app/home/data/model/news/news_request_model.dart';
import 'package:news_app/home/data/model/news/news_response_model.dart';

import '../../../helpers/nullable.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this._repository) : super(const NewsState());

  final HomeRepository _repository;
  RequestModel? requestModel;

  Future<void> news() async {
    final requestModel = NewsRequestModel(page: 1, limit: 7);
    await _news(requestModel);
  }

  Future<void> _news(NewsRequestModel requestModel) async {
    this.requestModel = requestModel;
    emit(state.requestLoading());
    final result = await _repository.news(requestModel);
    emit(
      result.fold((l) => state.requestFailed(l), (r) {
        return state.requestSuccess(r);
      }),
    );
  }

  void retry() {
    if (requestModel is NewsRequestModel) {
      _news(requestModel! as NewsRequestModel);
    }
  }
}
