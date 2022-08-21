import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../../discover/widgets/colored_tabbar.dart';
import 'friend_list_screen.dart';
import 'message_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
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
        title: Text(l10n.chat),
        bottom: ColoredTabBar(
          color: Colors.white,
          tabBar: TabBar(
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: [
              Tab(text: l10n.messages),
              Tab(text: l10n.friends),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MessageScreen(),
          FriendListScreen(),
        ],
      ),
    );
  }
}
