import 'package:news_app/home/data/model/parameter/email.dart';

class EmailMock {
  static const email = 'mohamed@mail.com';
  static const emailInvalid = 'email';
  static final emailMock = Email(email);
  static final emailMockInvalid = Email(emailInvalid);
}
