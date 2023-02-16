// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.currentTab,
    required this.currentNewsTab,
  });

  final NavigationTabs currentTab;
  final NewsTabs currentNewsTab;

  HomeState copyWith({
    NavigationTabs? currentTab,
    NewsTabs? currentNewsTab,
  }) {
    return HomeState(
      currentTab: currentTab ?? this.currentTab,
      currentNewsTab: currentNewsTab ?? this.currentNewsTab,
    );
  }

  @override
  List<Object> get props => [currentTab, currentNewsTab];
}
