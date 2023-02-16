import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/view/widgets/app_button.dart';
import 'package:news_app/app/view/widgets/app_screen.dart';
import 'package:news_app/data/api_manager/api_manager.dart';
import 'package:news_app/dependacy_injection/di.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/alert.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/helpers/generic_error_handler.dart';
import 'package:news_app/helpers/loader.dart';
import 'package:news_app/home/logic/contact_us/contact_us_cubit.dart';
import 'package:news_app/home/view/screen/contact_us_sucess_screen.dart';
import 'package:news_app/home/view/screen/widgets/contact_app_bar.dart';
import 'package:news_app/home/view/screen/widgets/contact_us_step_one.dart';
import 'package:news_app/home/view/screen/widgets/contact_us_step_two.dart';
import 'package:news_app/l10n/l10n.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const id = '/contact-us';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ContactUsCubit>(),
      child: const _Page(),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ContactUsCubit, ContactUsState>(
          listenWhen: (previous, current) =>
              previous.loading != current.loading,
          listener: (context, state) {
            state.loading
                ? Loader.instance.show(context)
                : Loader.instance.hide();
          },
        ),
        BlocListener<ContactUsCubit, ContactUsState>(
          listenWhen: (previous, current) =>
              previous.response != current.response && current.response != null,
          listener: (context, state) {
            Navigator.pushReplacementNamed(
              context,
              ContactUsSuccessScreen.id,
              arguments: state.response?.id,
            );
          },
        ),
        BlocListener<ContactUsCubit, ContactUsState>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure,
          listener: (context, state) {
            final failure = state.failure;
            if (failure is ErrorFailure) {
              final error = failure.error;
              if (error is MessageResponseModel) {
                Alert.instance.error(context, error.message);
              }
            } else if (failure != null) {
              GenericErrorHandler.instance.handle(
                failure: failure,
                onRetry: () => context.read<ContactUsCubit>().retry(),
                context: context,
              );
            }
          },
        ),
      ],
      child: AppScreen(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Assets.imagesLogo.image(width: 60),
          centerTitle: true,
          leading: BlocBuilder<ContactUsCubit, ContactUsState>(
            builder: (context, state) {
              return IconButton(
                icon: state.currentStep == 1
                    ? const Icon(
                        Icons.close,
                        color: AppColors.black,
                      )
                    : const Icon(
                        Icons.arrow_back,
                        color: AppColors.black,
                      ),
                onPressed: () {
                  if (state.currentStep == 1) {
                    Navigator.pop(context);
                  } else {
                    context.read<ContactUsCubit>().changeStep(1);
                  }
                },
              );
            },
          ),
          actions: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<ContactUsCubit, ContactUsState>(
                  builder: (context, state) {
                    return Text(
                      '${state.currentStep}/2',
                      style: const TextStyle(
                        color: AppColors.brownishGrey,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
          bottom: const ContactAppBar(),
        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      context.l10n.contact_with_us,
                      style: const TextStyle(
                        color: AppColors.darkBlueGrey,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  BlocBuilder<ContactUsCubit, ContactUsState>(
                    builder: (context, state) {
                      if (state.currentStep == 1) {
                        return const ContactUsStepOne();
                      } else {
                        return const ContactUsStepTwo();
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<ContactUsCubit, ContactUsState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: AppButton(
                          key: const Key('contact_us_button'),
                          textKey: state.currentStep == 1
                              ? context.l10n.next
                              : context.l10n.send,
                          onPressed: state.isFormValid
                              ? () {
                                  if (state.currentStep == 1) {
                                    context
                                        .read<ContactUsCubit>()
                                        .changeStep(2);
                                  } else {
                                    contactUs(context);
                                  }
                                }
                              : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void contactUs(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<ContactUsCubit>().contactUs();
  }
}
