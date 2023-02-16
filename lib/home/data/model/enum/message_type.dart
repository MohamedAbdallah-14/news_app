import 'package:flutter/material.dart';
import 'package:news_app/l10n/l10n.dart';

enum MessageType {
  complain,
  suggestion,
  inquery,
}

extension MessageTypeExtension on MessageType {
  String get value {
    switch (this) {
      case MessageType.complain:
        return 'complain';
      case MessageType.suggestion:
        return 'suggestion';
      case MessageType.inquery:
        return 'inquery';
    }
  }

  String translatedText(BuildContext context) {
    switch (this) {
      case MessageType.complain:
        return context.l10n.complain;
      case MessageType.suggestion:
        return context.l10n.suggestion;
      case MessageType.inquery:
        return context.l10n.inquery;
    }
  }
}
