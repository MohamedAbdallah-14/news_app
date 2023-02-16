import 'package:news_app/home/data/model/parameter/message_title.dart';

class MessageTitleMock {
  static const messageTitle = 'Title';
  static const messageTitleInvalid = '2';
  static final messageTitleMock = MessageTitle(messageTitle);
  static final messageTitleMockInvalid = MessageTitle(messageTitleInvalid);
}
