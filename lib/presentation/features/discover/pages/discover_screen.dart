import 'package:exchange_language_mobile/presentation/features/discover/widgets/colored_tabbar.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Discover'),
          bottom: ColoredTabBar(
            color: Colors.white,
            tabBar: TabBar(
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black,
              labelColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: 'Group'),
                Tab(text: 'Blog'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Discover'),
            ),
            Center(
              child: Text('Discover2'),
            ),
          ],
        ),
      ),
    );
  }
}
