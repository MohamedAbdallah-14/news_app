import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/helpers/nullable.dart';
import 'package:news_app/home/data/home_repository.dart';
import 'package:news_app/home/data/model/contact_us/contact_us_request_model.dart';
import 'package:news_app/home/data/model/contact_us/contact_us_response_model.dart';
import 'package:news_app/home/data/model/enum/message_type.dart';
import 'package:news_app/home/data/model/parameter/email.dart';
import 'package:news_app/home/data/model/parameter/message_description.dart';
import 'package:news_app/home/data/model/parameter/message_title.dart';
import 'package:news_app/home/data/model/parameter/mobile.dart';
import 'package:news_app/home/data/model/parameter/name.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this._repository) : super(const ContactUsState());

  final HomeRepository _repository;
  RequestModel? requestModel;

  Future<void> contactUs() async {
    if (!state.isFormValid) return;
    final requestModel = ContactUsRequestModel(
      firstName: state.firstName!,
      lastName: state.lastName!,
      email: state.email!,
      mobile: state.mobile!,
      messageTitle: state.messageTitle!,
      messageType: state.messageType!,
      messageDesc: state.messageDesc!,
      attachment: state.attachment,
    );
    await _contactUs(requestModel);
  }

  Future<void> _contactUs(ContactUsRequestModel requestModel) async {
    this.requestModel = requestModel;
    emit(state.requestLoading());
    final result = await _repository.contactUs(requestModel);
    emit(
      result.fold((l) => state.requestFailed(l), (r) {
        return state.requestSuccess(r);
      }),
    );
  }

  void changeStep(int step){
    emit(state.copyWith(currentStep:step));
  }

  void firstNameChanged(String value) {
    emit(state.copyWith(firstName: Name(value)));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(lastName: Name(value)));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: Email(value)));
  }

  void mobileChanged(String value) {
    emit(state.copyWith(mobile: Mobile(value)));
  }

  void messageTitleChanged(String value) {
    emit(state.copyWith(messageTitle: MessageTitle(value)));
  }

  void messageTypeChanged(MessageType value) {
    emit(state.copyWith(messageType: value));
  }

  void messageDescChanged(String value) {
    emit(state.copyWith(messageDesc: MessageDescription(value)));
  }

  void attachmentChanged(String value) {
    emit(state.copyWith(attachment: value));
  }

  void retry() {
    if (requestModel is ContactUsRequestModel) {
      _contactUs(requestModel! as ContactUsRequestModel);
    }
  }
}
