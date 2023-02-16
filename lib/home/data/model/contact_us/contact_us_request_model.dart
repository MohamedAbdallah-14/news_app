import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/home/data/model/enum/message_type.dart';
import 'package:news_app/home/data/model/parameter/email.dart';
import 'package:news_app/home/data/model/parameter/message_description.dart';
import 'package:news_app/home/data/model/parameter/message_title.dart';
import 'package:news_app/home/data/model/parameter/mobile.dart';
import 'package:news_app/home/data/model/parameter/name.dart';

class ContactUsRequestModel extends RequestModel {
  ContactUsRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.messageTitle,
    required this.messageType,
    required this.messageDesc,
    required this.attachment,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  final Name firstName;
  final Name lastName;
  final Email email;
  final Mobile mobile;
  final MessageTitle messageTitle;
  final MessageType messageType;
  final MessageDescription messageDesc;
  final String? attachment;

  @override
  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{
      'firstName': firstName.value.fold(
        (ValidationFailure l) => throw ValidationException(l.valueKey),
        (r) => r,
      ),
      'lastName': lastName.value.fold(
        (ValidationFailure l) => throw ValidationException(l.valueKey),
        (r) => r,
      ),
      'email': email.value.fold(
        (ValidationFailure l) => throw ValidationException(l.valueKey),
        (r) => r,
      ),
      'mobile': mobile.value.fold(
        (ValidationFailure l) => throw ValidationException(l.valueKey),
        (r) => r,
      ),
      'messageTitle': messageTitle.value.fold(
        (ValidationFailure l) => throw ValidationException(l.valueKey),
        (r) => r,
      ),
      'messageType': messageType.value,
      'messageDesc': messageDesc.value.fold(
        (ValidationFailure l) => throw ValidationException(l.valueKey),
        (r) => r,
      ),
    };
    if (attachment != null) {
      map['attachment'] = attachment;
    }
    return map;
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        messageTitle,
        messageType,
        messageDesc,
        attachment,
      ];
}
