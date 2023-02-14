import 'package:news_app/data/api_manager/models/failures/failure_info.dart';
import 'package:news_app/data/api_manager/models/failures/reportable_failure.dart';

class ServiceNotAvailableFailure extends ReportableFailure {
  ServiceNotAvailableFailure(FailureInfo failureInfo)
      : super(failureInfo: failureInfo, type: 'Service Not Available');
}
