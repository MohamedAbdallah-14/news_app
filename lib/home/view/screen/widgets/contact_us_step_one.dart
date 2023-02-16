import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/app_text_field.dart';
import 'package:news_app/home/logic/contact_us/contact_us_cubit.dart';
import 'package:news_app/l10n/l10n.dart';

class ContactUsStepOne extends StatelessWidget {
  const ContactUsStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ContactUsCubit, ContactUsState>(
          buildWhen: (previous, current) =>
              previous.firstName != current.firstName,
          builder: (context, state) {
            return AppTextField(
              key: const Key('contact_us_text_field_first_name'),
              initialValue: state.firstName?.value.fold((l) => null, (r) => r),
              labelKey: context.l10n.first_name,
              hintKey: context.l10n.enter_first_name,
              onChanged: (value) =>
                  context.read<ContactUsCubit>().firstNameChanged(value),
              validator: (string) => state.firstName?.value.fold(
                (l) => context.translate(l.valueKey),
                (r) => null,
              ),
            );
          },
        ),
        BlocBuilder<ContactUsCubit, ContactUsState>(
          buildWhen: (previous, current) =>
              previous.lastName != current.lastName,
          builder: (context, state) {
            return AppTextField(
              key: const Key('contact_us_text_field_last_name'),
              initialValue: state.lastName?.value.fold((l) => null, (r) => r),
              labelKey: context.l10n.last_name,
              hintKey: context.l10n.enter_last_name,
              onChanged: (value) =>
                  context.read<ContactUsCubit>().lastNameChanged(value),
              validator: (string) => state.lastName?.value.fold(
                (l) => context.translate(l.valueKey),
                (r) => null,
              ),
            );
          },
        ),
        BlocBuilder<ContactUsCubit, ContactUsState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            return AppTextField(
              key: const Key('contact_us_text_field_email'),
              initialValue: state.email?.value.fold((l) => null, (r) => r),
              labelKey: context.l10n.email,
              hintKey: context.l10n.mail_example,
              textDirection: TextDirection.ltr,
              onChanged: (value) =>
                  context.read<ContactUsCubit>().emailChanged(value),
              validator: (string) => state.email?.value.fold(
                (l) => context.translate(l.valueKey),
                (r) => null,
              ),
            );
          },
        ),
        BlocBuilder<ContactUsCubit, ContactUsState>(
          buildWhen: (previous, current) => previous.mobile != current.mobile,
          builder: (context, state) {
            return AppTextField(
              key: const Key('contact_us_text_field_mobile'),
              initialValue: state.mobile?.value.fold((l) => null, (r) => r),
              labelKey: context.l10n.mobile,
              hintKey: context.l10n.mobile_example,
              textDirection: TextDirection.ltr,
              onChanged: (value) =>
                  context.read<ContactUsCubit>().mobileChanged(value),
              validator: (string) => state.mobile?.value.fold(
                (l) => context.translate(l.valueKey),
                (r) => null,
              ),
            );
          },
        ),
      ],
    );
  }
}
