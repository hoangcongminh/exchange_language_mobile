import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../blog/pages/blog_screen.dart';
import '../../group/pages/group_screen.dart';
import '../widgets/colored_tabbar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.discover),
        bottom: ColoredTabBar(
          color: Colors.white,
          tabBar: TabBar(
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: [
              Tab(text: l10n.group),
              Tab(text: l10n.blog),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          GroupScreen(),
          BlogScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('discoverFab'),
        heroTag: 'discoverFab',
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (_tabController.index == 0) {
            AppNavigator().push(RouteConstants.createGroup);
          } else if (_tabController.index == 1) {
            AppNavigator().push(RouteConstants.createBlog);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
