import 'package:news_app/helpers/app_faker.dart';
import 'package:news_app/home/data/model/news/news_response_model.dart';
import 'package:news_app/home/data/model/news_model/mock/news_model_mock.dart';

class NewsResponseModelMock {
//*this return the !same! instance every time it's called
  static final mock = random;

  //*this return the !different! instance every time it's called
  static NewsResponseModel get random => NewsResponseModel(
        news: NewsModelMock.randomList,
      );

  static List<NewsResponseModel> get randomList => List.generate(
        AppFaker.randomInt(max: 10),
        (index) => random,
      );
}
