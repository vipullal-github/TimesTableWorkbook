import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenName;

  @override
  final Size preferredSize;

  const MyAppBar({key, required this.screenName})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(key: key, title: Text(screenName));
  }
}
