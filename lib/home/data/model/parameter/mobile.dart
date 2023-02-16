import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';

class Mobile extends Equatable {
  factory Mobile(String value) => Mobile._(_validateMobile(value));
  factory Mobile.error(ValidationFailure failure) => Mobile._(Left(failure));

  const Mobile._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateMobile(String value) {
    final phoneRegExp = RegExp(r'^05\d{8}$');
    if (phoneRegExp.hasMatch(value)) return Right(value);

    return Left(ValidationFailure('invalid_mobile'));
  }

  @override
  List<Object> get props => [value];
}
