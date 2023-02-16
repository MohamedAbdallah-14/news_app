import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/parameter/message_title.dart';
import 'package:news_app/home/data/model/parameter/mock/message_title_mock.dart';

void main() {
  group('message_title validator', () {
    test('''
given message_title class initialized when the value is corret then value should be message_title''',
        () async {
      // arrange
      final messageTitle = MessageTitle(MessageTitleMock.messageTitle);
      // act
      final value = messageTitle.value;
      // assert
      expect(
        value,
        const Right<dynamic, String>(MessageTitleMock.messageTitle),
      );
    });

    test('''
given message_title class initialized when the value is text then value should be ValidtorFailure''',
        () async {
      // arrange
      final messageTitle = MessageTitle(MessageTitleMock.messageTitleInvalid);
      // assert
      expect(
        messageTitle.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('invalid_message_title'),
        ),
      );
    });

    test('''
given message_title class initialized with error ValidationFailure then value should be ValidtorFailure''',
        () async {
      // arrange
      final messageTitle = MessageTitle.error(ValidationFailure('error'));
      // assert
      expect(
        messageTitle.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('error'),
        ),
      );
    });
  });
}
