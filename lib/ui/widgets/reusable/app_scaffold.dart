import 'package:flutter/material.dart';

import 'bottom_nav.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? trailing;
  final bool showBottomNav;
  final Color? appBarBackgroundColor;
  final TextStyle? titleTextStyle;
  final bool? centerTitle;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.trailing,
    this.showBottomNav = true,
    this.appBarBackgroundColor,
    this.titleTextStyle,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              backgroundColor: appBarBackgroundColor,
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              elevation: 0,
              centerTitle: centerTitle,
              title: Text(title!, style: titleTextStyle),
              actions: trailing != null ? [trailing!] : null,
            )
          : null,
      body: body,
      bottomNavigationBar: showBottomNav ? const BottomNav() : null,
    );
  }
}
