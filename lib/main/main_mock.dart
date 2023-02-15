import 'package:news_app/bootstrap.dart';
import 'package:news_app/flavor.dart';

void main() {
  AppFlavor.instance.flavor = Flavor.mock;
  bootstrap();
}
