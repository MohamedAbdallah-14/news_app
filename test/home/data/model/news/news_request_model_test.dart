import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/home/data/model/news/mock/news_request_model_mock.dart';

void main() {
  test(
    '''
NewsRequestModel toMap should have the the right parameters''',
    () async {
      /*act*/
      final map = await NewsRequestModelMock.mock.toMap();
      /*assert*/
      expect(map['page'], NewsRequestModelMock.pageMock);
      expect(map['limit'], NewsRequestModelMock.limitMock);
    },
  );
}
