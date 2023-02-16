import 'package:news_app/home/data/model/contact_us/contact_us_request_model.dart';
import 'package:news_app/home/data/model/enum/message_type.dart';
import 'package:news_app/home/data/model/parameter/mock/email_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/message_description_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/message_title_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/mobile_mock.dart';
import 'package:news_app/home/data/model/parameter/mock/name_mock.dart';

class ContactUsRequestModelMock {
  static const messageTypeMock = MessageType.complain;

  static const attachmentMock = 'base64String';

  static final mock = ContactUsRequestModel(
    firstName: NameMock.nameMock,
    lastName: NameMock.nameMock,
    email: EmailMock.emailMock,
    mobile: MobileMock.mobileMock,
    messageTitle: MessageTitleMock.messageTitleMock,
    messageType: messageTypeMock,
    messageDesc: MessageDescriptionMock.messageDescriptionMock,
    attachment: attachmentMock,
  );

  static final mockInvalidFirstName = ContactUsRequestModel(
    firstName: NameMock.nameMockInvalid,
    lastName: NameMock.nameMock,
    email: EmailMock.emailMock,
    mobile: MobileMock.mobileMock,
    messageTitle: MessageTitleMock.messageTitleMock,
    messageType: messageTypeMock,
    messageDesc: MessageDescriptionMock.messageDescriptionMock,
    attachment: attachmentMock,
  );

  static final mockInvalidLastName = ContactUsRequestModel(
    firstName: NameMock.nameMock,
    lastName: NameMock.nameMockInvalid,
    email: EmailMock.emailMock,
    mobile: MobileMock.mobileMock,
    messageTitle: MessageTitleMock.messageTitleMock,
    messageType: messageTypeMock,
    messageDesc: MessageDescriptionMock.messageDescriptionMock,
    attachment: attachmentMock,
  );

  static final mockInvalidEmail = ContactUsRequestModel(
    firstName: NameMock.nameMock,
    lastName: NameMock.nameMock,
    email: EmailMock.emailMockInvalid,
    mobile: MobileMock.mobileMock,
    messageTitle: MessageTitleMock.messageTitleMock,
    messageType: messageTypeMock,
    messageDesc: MessageDescriptionMock.messageDescriptionMock,
    attachment: attachmentMock,
  );

  static final mockInvalidMobile = ContactUsRequestModel(
    firstName: NameMock.nameMock,
    lastName: NameMock.nameMock,
    email: EmailMock.emailMock,
    mobile: MobileMock.mobileMockInvalid,
    messageTitle: MessageTitleMock.messageTitleMock,
    messageType: messageTypeMock,
    messageDesc: MessageDescriptionMock.messageDescriptionMock,
    attachment: attachmentMock,
  );

  static final mockInvalidMessageTitle = ContactUsRequestModel(
    firstName: NameMock.nameMock,
    lastName: NameMock.nameMock,
    email: EmailMock.emailMock,
    mobile: MobileMock.mobileMock,
    messageTitle: MessageTitleMock.messageTitleMockInvalid,
    messageType: messageTypeMock,
    messageDesc: MessageDescriptionMock.messageDescriptionMock,
    attachment: attachmentMock,
  );

  static final mockInvalidMessageDesc = ContactUsRequestModel(
    firstName: NameMock.nameMock,
    lastName: NameMock.nameMock,
    email: EmailMock.emailMock,
    mobile: MobileMock.mobileMock,
    messageTitle: MessageTitleMock.messageTitleMock,
    messageType: messageTypeMock,
    messageDesc: MessageDescriptionMock.messageDescriptionMockInvalid,
    attachment: attachmentMock,
  );
}
