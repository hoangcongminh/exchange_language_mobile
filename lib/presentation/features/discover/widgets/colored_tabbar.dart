import 'package:flutter/material.dart';

class ColoredTabBar extends ColoredBox implements PreferredSizeWidget {
  const ColoredTabBar({Key? key, required this.color, required this.tabBar})
      : super(key: key, color: color, child: tabBar);

  final TabBar tabBar;
  // ignore: overridden_fields, annotate_overrides
  final Color color;

  @override
  Size get preferredSize => tabBar.preferredSize;
}
