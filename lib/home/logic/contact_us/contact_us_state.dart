part of 'contact_us_cubit.dart';

class ContactUsState extends Equatable {
  const ContactUsState({
    this.currentStep = 1,
    this.loading = false,
    this.failure,
    this.response,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.messageTitle,
    this.messageType,
    this.messageDesc,
    this.attachment,
  });

  final int currentStep;
  final bool loading;
  final Failure? failure;
  final ContactUsResponseModel? response;
  final Name? firstName;
  final Name? lastName;
  final Email? email;
  final Mobile? mobile;
  final MessageTitle? messageTitle;
  final MessageType? messageType;
  final MessageDescription? messageDesc;
  final String? attachment;

  bool get isFormValid {
    if (currentStep == 1) {
      return (firstName?.value.isRight() ?? false) &&
          (lastName?.value.isRight() ?? false) &&
          (email?.value.isRight() ?? false) &&
          (mobile?.value.isRight() ?? false);
    } else {
      return (messageTitle?.value.isRight() ?? false) &&
          messageType != null &&
          (messageDesc?.value.isRight() ?? false);
    }
  }

  ContactUsState requestSuccess(ContactUsResponseModel response) =>
      copyWith(loading: false, response: Nullable(response));

  ContactUsState requestFailed(Failure failure) =>
      copyWith(loading: false, failure: Nullable(failure));

  ContactUsState requestLoading() => copyWith(
        loading: true,
        failure: Nullable(null),
        response: Nullable(null),
      );

  ContactUsState copyWith({
    int? currentStep,
    bool? loading,
    Nullable<Failure?>? failure,
    Nullable<ContactUsResponseModel?>? response,
    Name? firstName,
    Name? lastName,
    Email? email,
    Mobile? mobile,
    MessageTitle? messageTitle,
    MessageType? messageType,
    MessageDescription? messageDesc,
    String? attachment,
  }) {
    return ContactUsState(
      currentStep: currentStep ?? this.currentStep,
      loading: loading ?? this.loading,
      failure: failure == null ? this.failure : failure.value,
      response: response == null ? this.response : response.value,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      messageTitle: messageTitle ?? this.messageTitle,
      messageType: messageType ?? this.messageType,
      messageDesc: messageDesc ?? this.messageDesc,
      attachment: attachment ?? this.attachment,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        loading,
        failure,
        response,
        firstName,
        lastName,
        email,
        mobile,
        messageTitle,
        messageType,
        messageDesc,
        attachment,
      ];

  @override
  bool get stringify => true;
}
