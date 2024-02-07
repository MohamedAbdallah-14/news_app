import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/logic/contact_us/contact_us_cubit.dart';
import 'package:news_app/l10n/l10n.dart';

class ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContactAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              context.l10n.information,
              style: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Container(
              height: 4,
              width: MediaQuery.of(context).size.width / 2,
              margin: const EdgeInsets.only(top: 16),
              color: AppColors.primary,
            ),
          ],
        ),
        const Spacer(),
        Text(
          '${context.l10n.next}: ',
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        BlocBuilder<ContactUsCubit, ContactUsState>(
          builder: (context, state) {
            return Expanded(
              child: Text(
                state.currentStep == 1
                    ? context.l10n.additional_information
                    : context.l10n.send,
                style: const TextStyle(
                  color: AppColors.brownishGrey,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
                maxLines: 1,
              ),
            );
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
