import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';

class MessageDescription extends Equatable {
  factory MessageDescription(String value) =>
      MessageDescription._(_validateMessageDescription(value));
  factory MessageDescription.error(ValidationFailure failure) =>
      MessageDescription._(Left(failure));

  const MessageDescription._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateMessageDescription(
    String value,
  ) {
    if (value.length >= 3) return Right(value);

    return Left(ValidationFailure('invalid_message_description'));
  }

  @override
  List<Object> get props => [value];
}
