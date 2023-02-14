import 'package:news_app/data/api_manager/models/response_model.dart';

class MessageResponseModel extends ResponseModel {
  MessageResponseModel({required this.message});
  factory MessageResponseModel.fromMap(Map<String, dynamic> map) {
    final messageResponse = map['message'] ?? map['msg'];
    var message = '';
    if (messageResponse is String) {
      message = messageResponse;
    } else if (messageResponse is List) {
      message = messageResponse.join(', ');
    }

    return MessageResponseModel(
      message: message,
    );
  }
  final String message;

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  @override
  List<Object?> get props => [
        message,
      ];
}
