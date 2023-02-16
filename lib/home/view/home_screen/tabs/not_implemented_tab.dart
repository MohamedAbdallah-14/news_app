import 'package:flutter/material.dart';
import 'package:news_app/l10n/l10n.dart';

class NotImplementedTab extends StatelessWidget {
  const NotImplementedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.l10n.not_implemented),
    );
  }
}
