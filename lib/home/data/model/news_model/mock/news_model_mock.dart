import 'package:news_app/helpers/app_faker.dart';
import 'package:news_app/home/data/model/news_model/news_model.dart';

class NewsModelMock {
//*this return the !same! instance every time it's called
  static final mock = random;

  //*this return the !different! instance every time it's called
  static NewsModel get random => NewsModel(
        id: AppFaker.randomId.toString(),
        titleAr: AppFaker.words,
        titleEn: AppFaker.words,
        contentAr: AppFaker.sentence,
        contentEn: AppFaker.sentence,
        image: AppFaker.image,
        createdAt: AppFaker.dateTime,
      );

  static List<NewsModel> get randomList => List.generate(
        AppFaker.randomInt(max: 10),
        (index) => random,
      );
}
