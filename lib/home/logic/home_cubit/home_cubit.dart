import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/home/view/home_screen/tabs_enum.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          const HomeState(
            currentTab: NavigationTabs.home,
            currentNewsTab: NewsTabs.news,
          ),
        );

  void changeTab(NavigationTabs tab) {
    emit(state.copyWith(currentTab: tab));
  }

  void changeNewsTab(NewsTabs tab) {
    emit(state.copyWith(currentNewsTab: tab));
  }
}
