import 'package:news_app/data/api_manager/models/failures/failure.dart';

class ValidationFailure extends Failure {
  ValidationFailure(this.valueKey);
  final String valueKey;

  @override
  List<Object?> get props => [id, valueKey];
}
