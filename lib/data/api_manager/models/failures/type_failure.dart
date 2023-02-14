import 'package:news_app/data/api_manager/models/failures/failure_info.dart';
import 'package:news_app/data/api_manager/models/failures/reportable_failure.dart';

class TypeFailure extends ReportableFailure {
  TypeFailure(FailureInfo failureInfo, [this.data])
      : super(failureInfo: failureInfo, type: 'TypeError');
  final dynamic data;
}
