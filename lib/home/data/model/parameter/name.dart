import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/models/failures/validation_failure.dart';

class Name extends Equatable {
  factory Name(String value) => Name._(_validateName(value));
  factory Name.error(ValidationFailure failure) => Name._(Left(failure));

  const Name._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateName(String value) {
    if (RegExp(r'^[a-zA-Z\u0621-\u064A]{3,25}$').hasMatch(value)) {
      return Right(value);
    }

    return Left(ValidationFailure('invalid_name'));
  }

  @override
  List<Object> get props => [value];
}
