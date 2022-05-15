import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../blog/pages/blog_screen.dart';
import '../../group/group_screen.dart';
import '../widgets/colored_tabbar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.notification),
          bottom: const ColoredTabBar(
            color: Colors.white,
            tabBar: TabBar(
              tabs: [
                Tab(text: 'Group'),
                Tab(text: 'Blog'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            GroupScreen(),
            BlogScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
