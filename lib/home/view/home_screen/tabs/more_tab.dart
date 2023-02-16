import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/generated/assets.gen.dart';
import 'package:news_app/helpers/alert.dart';
import 'package:news_app/helpers/app_colors.dart';
import 'package:news_app/home/logic/language_cubit/language_cubit.dart';
import 'package:news_app/home/view/home_screen/widgets/more_cell.dart';
import 'package:news_app/home/view/screen/contact_us_screen.dart';
import 'package:news_app/l10n/l10n.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Assets.imagesLogo.image(width: 70),
                ),
                const SizedBox(height: 32),
                ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    MoreCell(
                      title: context.l10n.clubs_directory,
                      color: AppColors.veryLightPink,
                    ),
                    MoreCell(
                      title: context.l10n.stadium_directory,
                      color: AppColors.veryLightPink,
                    ),
                    MoreCell(
                      title: context.l10n.who_are_we,
                      color: AppColors.strawberry,
                    ),
                    MoreCell(
                      title: context.l10n.regulations,
                      color: AppColors.turtleGreen,
                    ),
                    MoreCell(
                      title: context.l10n.committees,
                      color: AppColors.greyblue,
                    ),
                    MoreCell(
                      title: context.l10n.contact_us,
                      color: AppColors.veryLightPink,
                      onPressed: () =>
                          Navigator.pushNamed(context, ContactUsScreen.id),
                    ),
                    MoreCell(
                      title: context.l10n.share_app,
                      color: AppColors.strawberry,
                    ),
                    MoreCell(
                      title: context.l10n.subscribe_to_news_letter,
                      color: AppColors.turtleGreen,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Alert.instance
                              .error(context, context.l10n.not_implemented),
                          icon: Assets.imagesIconsFacebook.svg(),
                        ),
                        IconButton(
                          onPressed: () => Alert.instance
                              .error(context, context.l10n.not_implemented),
                          icon: Assets.imagesIconsTwitter.svg(),
                        ),
                        IconButton(
                          onPressed: () => Alert.instance
                              .error(context, context.l10n.not_implemented),
                          icon: Assets.imagesIconsInstagram.svg(),
                        ),
                        IconButton(
                          onPressed: () => Alert.instance
                              .error(context, context.l10n.not_implemented),
                          icon: Assets.imagesIconsLinkedin.svg(),
                        ),
                        IconButton(
                          onPressed: () => Alert.instance
                              .error(context, context.l10n.not_implemented),
                          icon: Assets.imagesIconsYoutube.svg(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    IconButton(
                      onPressed: () {
                        context.read<LanguageCubit>().toggleLanguage();
                      },
                      icon: Row(
                        textDirection: state.languageCode == 'en'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.imagesIconsTranslate.svg(),
                          const SizedBox(width: 8),
                          Text(
                            state.languageCode == 'en' ? 'العربية' : 'English',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
