import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/home/data/model/contact_us/contact_us_response_model.dart';
import 'package:news_app/home/data/model/contact_us/mock/contact_us_response_model_mock.dart';

void main() {
  test('ContactUsResponseModel should be able to convert from and to json',
      () async {
    // arrange
    final json = ContactUsResponseModelMock.mock.toMap();
    // act
    final contactUs = ContactUsResponseModel.fromMap(json);
    // assert
    expect(contactUs, ContactUsResponseModelMock.mock);
  });
}
