import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/view/home_screen/tabs/home_tab.dart';
import 'package:news_app/home/view/home_screen/tabs/more_tab.dart';
import 'package:news_app/home/view/home_screen/tabs/news_tab.dart';
import 'package:news_app/home/view/home_screen/tabs/not_implemented_tab.dart';
import 'package:news_app/home/view/home_screen/tabs_enum.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(currentTab: NavigationTabs.home));

  void changeTab(NavigationTabs tab) {
    emit(HomeState(currentTab: tab));
  }
}
