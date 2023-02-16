import 'package:news_app/home/data/model/parameter/message_description.dart';

class MessageDescriptionMock {
  static const messageDescription = 'validMessage';
  static const messageDescriptionInvalid = '1';
  static final messageDescriptionMock = MessageDescription(messageDescription);
  static final messageDescriptionMockInvalid = MessageDescription(
    messageDescriptionInvalid,
  );
}
