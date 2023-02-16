import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/parameter/message_description.dart';
import 'package:news_app/home/data/model/parameter/mock/message_description_mock.dart';

void main() {
  group('message_description validator', () {
    test('''
given message_description class initialized when the value is corret then value should be message_description''',
        () async {
      // arrange
      final messageDescription = MessageDescription(
        MessageDescriptionMock.messageDescription,
      );
      // act
      final value = messageDescription.value;
      // assert
      expect(
        value,
        const Right<dynamic, String>(MessageDescriptionMock.messageDescription),
      );
    });

    test('''
given messageDescription class initialized when the value is text then value should be ValidtorFailure''',
        () async {
      // arrange
      final messageDescription =
          MessageDescription(MessageDescriptionMock.messageDescriptionInvalid);
      // assert
      expect(
        messageDescription.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('invalid_message_description'),
        ),
      );
    });

    test('''
given messageDescription class initialized with error ValidationFailure then value should be ValidtorFailure''',
        () async {
      // arrange
      final messageDescription =
          MessageDescription.error(ValidationFailure('error'));
      // assert
      expect(
        messageDescription.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('error'),
        ),
      );
    });
  });
}
