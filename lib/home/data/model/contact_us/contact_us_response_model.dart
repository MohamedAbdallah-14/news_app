import 'package:equatable/equatable.dart';
import 'package:news_app/data/api_manager/api_manager.dart';

class ContactUsResponseModel extends Equatable implements ResponseModel {
  const ContactUsResponseModel({
    required this.id,
  });

  factory ContactUsResponseModel.fromMap(Map<String, dynamic> map) {
    return ContactUsResponseModel(
      id: map['id'] as String,
    );
  }

  final String id;

  Map<String, dynamic> toMap() => {
        'id': id,
      };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
      ];
}
