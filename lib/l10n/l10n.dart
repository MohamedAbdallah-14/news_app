import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String translate(String key) {
    switch (key) {
      case 'invalid_email':
        return l10n.invalid_email;
      case 'invalid_message_description':
        return l10n.invalid_message_description;
      case 'invalid_message_title':
        return l10n.invalid_message_title;
      case 'invalid_mobile':
        return l10n.invalid_mobile;
      case 'invalid_name':
        return l10n.invalid_name;
    }
    return key;
  }
}
