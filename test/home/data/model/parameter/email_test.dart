import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/parameter/email.dart';
import 'package:news_app/home/data/model/parameter/mock/email_mock.dart';

void main() {
  group('email validator', () {
    test('''
given email class initialized when the value is corret then value should be email''',
        () async {
      // arrange
      final email = Email(EmailMock.email);
      // act
      final value = email.value;
      // assert
      expect(value, const Right<dynamic, String>(EmailMock.email));
    });

    test('''
given email class initialized when the value is text then value should be ValidtorFailure''',
        () async {
      // arrange
      final email = Email(EmailMock.emailInvalid);
      // assert
      expect(
        email.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('invalid_email'),
        ),
      );
    });

    test('''
given email class initialized with error ValidationFailure then value should be ValidtorFailure''',
        () async {
      // arrange
      final email = Email.error(ValidationFailure('error'));
      // assert
      expect(
        email.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('error'),
        ),
      );
    });
  });
}
