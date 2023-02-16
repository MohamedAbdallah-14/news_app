import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';

class MessageTitle extends Equatable {
  factory MessageTitle(String value) =>
      MessageTitle._(_validateMessageTitle(value));
  factory MessageTitle.error(ValidationFailure failure) =>
      MessageTitle._(Left(failure));

  const MessageTitle._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateMessageTitle(String value) {
    if (value.length >= 3 && value.length <= 50) return Right(value);

    return Left(ValidationFailure('invalid_message_title'));
  }

  @override
  List<Object> get props => [value];
}
