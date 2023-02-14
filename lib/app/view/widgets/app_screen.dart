import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    this.child,
    this.bottomNavigationBar,
    this.appBar,
    this.backgroundColor,
  });

  final Widget? child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
