import 'package:exchange_language_mobile/common/services/socket/socket.dart';
import 'package:exchange_language_mobile/presentation/features/chat/pages/chat_screen.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/widgets/bottom_bar_item.dart';
import 'package:exchange_language_mobile/presentation/features/discover/pages/discover_screen.dart';
import 'package:exchange_language_mobile/presentation/features/filter/pages/filter_screen.dart';
import 'package:exchange_language_mobile/presentation/features/notification/pages/notification_screen.dart';
import 'package:exchange_language_mobile/presentation/features/user-profile/pages/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('DashboardScreen initState');
    connectAndListen();
    // AppBloc.initialHomeBloc();
  }

  final List<Widget> _tabs = const [
    ChatScreen(),
    NotificationScreen(),
    DiscoverScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FilterScreen()));
        },
        child: const Icon(Icons.person_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 40.sp,
          padding: EdgeInsets.symmetric(horizontal: 6.5.sp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: .2,
              ),
            ),
          ),
          child: Row(
            children: [
              BottomBarItem(
                  activeIcon: Icons.chat,
                  inactiveIcon: Icons.chat_outlined,
                  index: 0),
              BottomBarItem(
                  activeIcon: Icons.notifications,
                  inactiveIcon: Icons.notifications_outlined,
                  index: 1),
              SizedBox(width: 51.sp),
              BottomBarItem(
                  activeIcon: Icons.people,
                  inactiveIcon: Icons.people_outline,
                  index: 2),
              BottomBarItem(
                  activeIcon: Icons.person,
                  inactiveIcon: Icons.person_outline,
                  index: 3),
            ],
          ),
        ),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return _tabs[state.index];
        },
      ),
    );
  }
}
