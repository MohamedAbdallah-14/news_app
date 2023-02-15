part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.currentTab,
  });

  final NavigationTabs currentTab;

  Widget get tabWidget {
    switch (currentTab) {
      case NavigationTabs.home:
        return const HomeTab();
      case NavigationTabs.table:
        return const NotImplementedTab();
      case NavigationTabs.news:
        return const NewsTab();
      case NavigationTabs.statistics:
        return const NotImplementedTab();
      case NavigationTabs.more:
        return const NotImplementedTab();
    }
  }

  @override
  List<Object> get props => [currentTab];
}
