import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/contact_us/contact_us_request_model.dart';

class ContactUsRequest with Request, PostRequest {
  const ContactUsRequest(this.requestModel);

  @override
  final ContactUsRequestModel requestModel;

  @override
  String get path => 'contactus';
}
