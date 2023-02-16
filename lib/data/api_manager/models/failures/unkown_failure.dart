import 'package:news_app/data/api_manager/models/failures/failure_info.dart';
import 'package:news_app/data/api_manager/models/failures/reportable_failure.dart';

class UnkownFailure extends ReportableFailure {
  UnkownFailure(FailureInfo failureInfo)
      : super(failureInfo: failureInfo, type: 'Unkown Failure');
}
