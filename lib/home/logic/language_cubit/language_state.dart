part of 'language_cubit.dart';

class LanguageState extends Equatable {
  const LanguageState({this.languageCode = 'ar'});

  factory LanguageState.fromMap(Map<String, dynamic> map) => LanguageState(
        languageCode: map['languageCode'] as String,
      );

  final String languageCode;

  Locale get locale => Locale.fromSubtags(languageCode: languageCode);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'languageCode': languageCode,
      };

  @override
  List<Object> get props => [languageCode];
}
