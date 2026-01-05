import 'package:flutter/material.dart';

import 'bottom_nav.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? trailing;
  final bool showBottomNav;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.trailing,
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              actions: trailing != null ? [trailing!] : null,
            )
          : null,
      body: body,
      bottomNavigationBar: showBottomNav ? const BottomNav() : null,
    );
  }
}
