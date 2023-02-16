import 'package:news_app/home/data/model/parameter/mobile.dart';

class MobileMock {
  static const mobile = '0512345678';
  static const mobileInvalid = '1';
  static final mobileMock = Mobile(mobile);
  static final mobileMockInvalid = Mobile(mobileInvalid);
}
