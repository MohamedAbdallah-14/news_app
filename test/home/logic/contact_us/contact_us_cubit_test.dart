import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/home/data/model/parameter/email.dart';
import 'package:news_app/home/data/model/parameter/message_description.dart';
import 'package:news_app/home/data/model/parameter/message_title.dart';
import 'package:news_app/home/data/model/parameter/mock/email_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/message_description_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/message_title_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/name_mock.dart';
import 'package:news_app/home/data/model/parameter/name.dart';
import 'package:news_app/home/logic/contact_us/contact_us_cubit.dart';

import '../../faker.dart';

void main() {
  late ContactUsCubit contactUsCubit;
  late MockHomeRepository repository;

  setUpAll(setupFaker);

  setUp(() {
    repository = MockHomeRepository();
    contactUsCubit = ContactUsCubit(repository);
  });

  test('Initial state loading should be false', () {
    expect(contactUsCubit.state, const ContactUsState());
  });

  blocTest<ContactUsCubit, ContactUsState>(
    '''
firstNameChanged should instantiate new instance of FirstName into state and invalid form''',
    build: () => contactUsCubit,
    act: (ContactUsCubit cubit) => cubit.firstNameChanged('1'),
    expect: () => [ContactUsState(firstName: Name(NameMock.nameInvalid))],
    verify: (ContactUsCubit cubit) {
      expect(cubit.state.isFormValid, false);
    },
  );

  blocTest<ContactUsCubit, ContactUsState>(
    '''
lastNameChanged should instantiate new instance of LastName into state and invalid form''',
    build: () => contactUsCubit,
    act: (ContactUsCubit cubit) => cubit.lastNameChanged('1'),
    expect: () => [ContactUsState(lastName: Name(NameMock.nameInvalid))],
    verify: (ContactUsCubit cubit) {
      expect(cubit.state.isFormValid, false);
    },
  );

  blocTest<ContactUsCubit, ContactUsState>(
    '''
emailChanged should instantiate new instance of Email into state and invalid form''',
    build: () => contactUsCubit,
    act: (ContactUsCubit cubit) => cubit.emailChanged('1'),
    expect: () => [ContactUsState(email: Email(EmailMock.emailInvalid))],
    verify: (ContactUsCubit cubit) {
      expect(cubit.state.isFormValid, false);
    },
  );

  blocTest<ContactUsCubit, ContactUsState>(
    '''
messageTitleChanged should instantiate new instance of MessageTitle into state and invalid form''',
    build: () => contactUsCubit,
    act: (ContactUsCubit cubit) => cubit.messageTitleChanged('1'),
    expect: () => [
      ContactUsState(
        messageTitle: MessageTitle(MessageTitleMock.messageTitleInvalid),
      ),
    ],
    verify: (ContactUsCubit cubit) {
      expect(cubit.state.isFormValid, false);
    },
  );

  blocTest<ContactUsCubit, ContactUsState>(
    '''
messageDescChanged should instantiate new instance of MessageDesc into state and invalid form''',
    build: () => contactUsCubit,
    act: (ContactUsCubit cubit) => cubit.messageDescChanged('1'),
    expect: () => [
      ContactUsState(
        messageDesc: MessageDescription(
          MessageDescriptionMock.messageDescriptionInvalid,
        ),
      ),
    ],
    verify: (ContactUsCubit cubit) {
      expect(cubit.state.isFormValid, false);
    },
  );

  blocTest<ContactUsCubit, ContactUsState>(
    '''
firstName and lastName and email and messageTitle and messageDesc and changed should emit state with isValidForm true is all are valid''',
    build: () => contactUsCubit,
    act: (ContactUsCubit cubit) => cubit
      ..firstNameChanged(NameMock.name)
      ..lastNameChanged(NameMock.name)
      ..emailChanged(EmailMock.email)
      ..messageTitleChanged(MessageTitleMock.messageTitle)
      ..messageDescChanged(MessageDescriptionMock.messageDescription),
    expect: () => [
      ContactUsState(
        firstName: Name(NameMock.name),
      ),
      ContactUsState(
        firstName: Name(NameMock.name),
        lastName: Name(NameMock.name),
      ),
      ContactUsState(
        firstName: Name(NameMock.name),
        lastName: Name(NameMock.name),
        email: Email(EmailMock.email),
      ),
      ContactUsState(
        firstName: Name(NameMock.name),
        lastName: Name(NameMock.name),
        email: Email(EmailMock.email),
        messageTitle: MessageTitle(MessageTitleMock.messageTitle),
      ),
      ContactUsState(
        firstName: Name(NameMock.name),
        lastName: Name(NameMock.name),
        email: Email(EmailMock.email),
        messageTitle: MessageTitle(MessageTitleMock.messageTitle),
        messageDesc:
            MessageDescription(MessageDescriptionMock.messageDescription),
      ),
    ],
  );
}
