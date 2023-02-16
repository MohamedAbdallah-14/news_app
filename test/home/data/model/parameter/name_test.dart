import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/parameter/mock/name_mock.dart';
import 'package:news_app/home/data/model/parameter/name.dart';

void main() {
  group('name validator', () {
    test('''
given name class initialized when the value is corret then value should be name''',
        () async {
      // arrange
      final name = Name(NameMock.name);
      // act
      final value = name.value;
      // assert
      expect(value, const Right<dynamic, String>(NameMock.name));
    });

    test('''
given name class initialized when the value is text then value should be ValidtorFailure''',
        () async {
      // arrange
      final name = Name(NameMock.nameInvalid);
      // assert
      expect(
        name.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('invalid_name'),
        ),
      );
    });

    test('''
given name class initialized with error ValidationFailure then value should be ValidtorFailure''',
        () async {
      // arrange
      final name = Name.error(ValidationFailure('error'));
      // assert
      expect(
        name.value,
        Left<ValidationFailure, dynamic>(
          ValidationFailure('error'),
        ),
      );
    });
  });
}
