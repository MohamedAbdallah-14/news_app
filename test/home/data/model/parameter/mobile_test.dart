import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/parameter/mobile.dart';
import 'package:news_app/home/data/model/parameter/mock/mobile_mock.dart';

void main() {
  group('mobile validator', () {
    test('''
given mobile class initialized when the value is corret then value should be mobile''',
        () async {
      // arrange
      final mobile = Mobile(MobileMock.mobile);
      // act
      final value = mobile.value;
      // assert
      expect(
        value,
        const Right<dynamic, String>(MobileMock.mobile),
      );
    });

    test('''
given mobile class initialized when the value is text then value should be ValidtorFailure''',
        () async {
      // arrange
      final mobile = Mobile(MobileMock.mobileInvalid);
      // assert
      expect(
        mobile.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('invalid_mobile'),
        ),
      );
    });

    test('''
given mobile class initialized with error ValidationFailure then value should be ValidtorFailure''',
        () async {
      // arrange
      final mobile = Mobile.error(ValidationFailure('error'));
      // assert
      expect(
        mobile.value,
        Left<ValidationFailure, dynamic>(ValidationFailure('error')),
      );
    });
  });
}
