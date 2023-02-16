import 'package:flutter/material.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/data/model/enum/message_type.dart';

class MessageTypeCell extends StatelessWidget {
  const MessageTypeCell({
    required this.messageType,
    required this.selectedType,
    required this.onChanged,
    super.key,
  });

  final MessageType messageType;
  final MessageType? selectedType;
  final void Function(MessageType?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: messageType == selectedType ? AppColors.softBlue23 : null,
        border: Border.all(
          color: messageType == selectedType
              ? AppColors.primary
              : AppColors.veryLightPink,
        ),
      ),
      child: RadioListTile<MessageType?>(
        value: messageType,
        groupValue: selectedType,
        toggleable: true,
        activeColor: AppColors.primary,
        controlAffinity: ListTileControlAffinity.trailing,
        onChanged: onChanged,
        selectedTileColor: AppColors.softBlue23,
        title: Text(
          messageType.translatedText(context),
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
