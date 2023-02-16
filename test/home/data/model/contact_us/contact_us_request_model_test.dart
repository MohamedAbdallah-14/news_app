import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/contact_us/mock/contact_us_request_model_mock.dart';
import 'package:news_app/home/data/model/enum/message_type.dart';
import 'package:news_app/home/data/model/parameter/mock/email_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/message_description_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/message_title_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/name_mock.dart';

void main() {
  test(
    '''
ContactUsRequestModel toMap should have the the right parameters''',
    () async {
      /*act*/
      final map = await ContactUsRequestModelMock.mock.toMap();
      /*assert*/
      expect(map['firstName'], NameMock.name);
      expect(map['lastName'], NameMock.name);
      expect(map['email'], EmailMock.email);
      expect(map['messageTitle'], MessageTitleMock.messageTitle);
      expect(
        map['messageType'],
        ContactUsRequestModelMock.messageTypeMock.value,
      );
      expect(map['messageDesc'], MessageDescriptionMock.messageDescription);
    },
  );

  test(
    '''
ContactUsRequestModel toMap should throw ValidationException if firstName is not valid''',
    () async {
      expect(
        ContactUsRequestModelMock.mockInvalidFirstName.toMap(),
        throwsA(
          predicate(
            (e) => e is ValidationException && e.value == 'invalid_name',
          ),
        ),
      );
    },
  );

  test(
    '''
ContactUsRequestModel toMap should throw ValidationException if lastName is not valid''',
    () async {
      expect(
        ContactUsRequestModelMock.mockInvalidLastName.toMap(),
        throwsA(
          predicate(
            (e) => e is ValidationException && e.value == 'invalid_name',
          ),
        ),
      );
    },
  );

  test(
    '''
ContactUsRequestModel toMap should throw ValidationException if email is not valid''',
    () async {
      expect(
        ContactUsRequestModelMock.mockInvalidEmail.toMap(),
        throwsA(
          predicate(
            (e) => e is ValidationException && e.value == 'invalid_email',
          ),
        ),
      );
    },
  );

  test(
    '''
ContactUsRequestModel toMap should throw ValidationException if messageTitle is not valid''',
    () async {
      expect(
        ContactUsRequestModelMock.mockInvalidMessageTitle.toMap(),
        throwsA(
          predicate(
            (e) =>
                e is ValidationException && e.value == 'invalid_message_title',
          ),
        ),
      );
    },
  );

  test(
    '''
ContactUsRequestModel toMap should throw ValidationException if messageDesc is not valid''',
    () async {
      expect(
        ContactUsRequestModelMock.mockInvalidMessageDesc.toMap(),
        throwsA(
          predicate(
            (e) =>
                e is ValidationException &&
                e.value == 'invalid_message_description',
          ),
        ),
      );
    },
  );
}
