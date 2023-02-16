import 'package:news_app/helpers/app_faker.dart';
import 'package:news_app/home/data/model/contact_us/contact_us_response_model.dart';

class ContactUsResponseModelMock {
//*this return the !same! instance every time it's called
  static final mock = random;

  //*this return the !different! instance every time it's called
  static ContactUsResponseModel get random => ContactUsResponseModel(
        id: AppFaker.randomId.toString(),
      );

  static List<ContactUsResponseModel> get randomList => List.generate(
        AppFaker.randomInt(max: 10),
        (index) => random,
      );
}
