import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_state.dart';

bool ltr = false;

class LanguageCubit extends HydratedCubit<LanguageState> {
  LanguageCubit() : super(const LanguageState());

  void changeLanguage(String? languageCode) {
    if (languageCode == null || languageCode == state.languageCode) return;

    emit(LanguageState(languageCode: languageCode));
  }

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      changeLanguage('ar');
    } else {
      changeLanguage('en');
    }
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) =>
      LanguageState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    ltr = state.languageCode == 'en';
    return state.toMap();
  }
}
