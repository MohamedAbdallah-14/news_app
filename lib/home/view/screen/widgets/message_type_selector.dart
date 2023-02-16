import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/app_button.dart';
import 'package:news_app/home/data/model/enum/message_type.dart';
import 'package:news_app/home/logic/contact_us/contact_us_cubit.dart';
import 'package:news_app/home/view/screen/widgets/message_type_cell.dart';
import 'package:news_app/l10n/l10n.dart';

class MessageTypeSelector extends StatefulWidget {
  const MessageTypeSelector({super.key});

  @override
  State<MessageTypeSelector> createState() => _MessageTypeSelectorState();
}

class _MessageTypeSelectorState extends State<MessageTypeSelector> {
  MessageType? messageType;

  @override
  void initState() {
    super.initState();
    messageType = context.read<ContactUsCubit>().state.messageType;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MessageTypeCell(
            messageType: MessageType.complain,
            selectedType: messageType,
            onChanged: (value) => setState(() => messageType = value),
          ),
          MessageTypeCell(
            messageType: MessageType.suggestion,
            selectedType: messageType,
            onChanged: (value) => setState(() => messageType = value),
          ),
          MessageTypeCell(
            messageType: MessageType.inquery,
            selectedType: messageType,
            onChanged: (value) => setState(() => messageType = value),
          ),
          const SizedBox(height: 32),
          AppButton(
            textKey: context.l10n.choose,
            onPressed: messageType == null
                ? null
                : () {
                    context
                        .read<ContactUsCubit>()
                        .messageTypeChanged(messageType!);
                    Navigator.pop(context);
                  },
          )
        ],
      ),
    );
  }
}
