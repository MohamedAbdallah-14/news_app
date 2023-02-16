import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/app_bottom_sheet.dart';
import 'package:news_app/app/view/widgets/app_button.dart';
import 'package:news_app/app/view/widgets/app_text_field.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/data/model/enum/message_type.dart';
import 'package:news_app/home/logic/contact_us/contact_us_cubit.dart';
import 'package:news_app/home/view/screen/widgets/message_type_selector.dart';
import 'package:news_app/l10n/l10n.dart';

class ContactUsStepTwo extends StatefulWidget {
  const ContactUsStepTwo({super.key});

  @override
  State<ContactUsStepTwo> createState() => _ContactUsStepTwoState();
}

class _ContactUsStepTwoState extends State<ContactUsStepTwo> {
  final messageTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ContactUsCubit, ContactUsState>(
          buildWhen: (previous, current) =>
              previous.messageTitle != current.messageTitle,
          builder: (context, state) {
            return AppTextField(
              key: const Key('contact_us_text_field_message_title'),
              labelKey: context.l10n.message_title,
              hintKey: context.l10n.enter_message_title,
              onChanged: (value) =>
                  context.read<ContactUsCubit>().messageTitleChanged(value),
              validator: (string) => state.messageTitle?.value.fold(
                (l) => context.translate(l.valueKey),
                (r) => null,
              ),
            );
          },
        ),
        BlocConsumer<ContactUsCubit, ContactUsState>(
          listenWhen: (previous, current) =>
              previous.messageType != current.messageType,
          listener: (context, state) => messageTypeController.text =
              state.messageType?.translatedText(context) ?? '',
          buildWhen: (previous, current) =>
              previous.messageType != current.messageType,
          builder: (context, state) {
            return AppTextField(
              key: const Key('contact_us_text_field_message_type'),
              labelKey: context.l10n.message_type,
              controller: messageTypeController,
              hintKey: context.l10n.choose_message_type,
              userInput: false,
              suffixIcon: const Icon(Icons.arrow_drop_down),
              onUserTap: () {
                showAppModalBottomSheet<ContactUsCubit>(
                  context: context,
                  titleKey: context.l10n.choose_message_type,
                  bloc: context.read<ContactUsCubit>(),
                  percentOfScreenHeight: 0.75,
                  widgetsList: const [MessageTypeSelector()],
                );
              },
            );
          },
        ),
        BlocBuilder<ContactUsCubit, ContactUsState>(
          buildWhen: (previous, current) =>
              previous.messageDesc != current.messageDesc,
          builder: (context, state) {
            return AppTextField(
              key: const Key('contact_us_text_field_message_desc'),
              labelKey: context.l10n.message_desc,
              hintKey: context.l10n.type,
              maxLines: 4,
              onChanged: (value) =>
                  context.read<ContactUsCubit>().messageDescChanged(value),
              validator: (string) => state.messageDesc?.value.fold(
                (l) => context.translate(l.valueKey),
                (r) => null,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              context.l10n.attachment,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            Text(
              ' ${context.l10n.optional}',
              style: const TextStyle(
                color: AppColors.brownGrey,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
          ],
        ),
        BlocBuilder<ContactUsCubit, ContactUsState>(
          buildWhen: (previous, current) =>
              previous.attachment != current.attachment,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                mainButton: false,
                textKey: context.l10n.attach_file_or_image,
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();

                  if (result != null) {
                    final file = File(result.files.single.path!);
                    if (context.mounted) {
                      context.read<ContactUsCubit>().attachmentChanged(file);
                    }
                  }
                },
                child: state.attachment == null
                    ? null
                    : Row(
                        children: [
                          Assets.imagesIconsFileIcon.svg(),
                          const SizedBox(width: 8),
                          Text(
                            state.attachment?.path.split('/').last ?? '',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              height: 1,
                              fontSize: 17,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => context
                                .read<ContactUsCubit>()
                                .attachmentChanged(null),
                            icon: Assets.imagesIconsClose.svg(),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    messageTypeController.dispose();
    super.dispose();
  }
}
