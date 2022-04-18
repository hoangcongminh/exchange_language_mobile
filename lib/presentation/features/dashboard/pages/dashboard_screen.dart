import 'package:exchange_language_mobile/presentation/common-bloc/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/widgets/bottom_bar_item.dart';
import 'package:flutter/material.dart';
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

    // AppBloc.initialHomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
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
              const BottomBarItem(
                  activeIcon: Icons.chat,
                  inactiveIcon: Icons.chat_outlined,
                  index: 0),
              const BottomBarItem(
                  activeIcon: Icons.notifications,
                  inactiveIcon: Icons.notifications_outlined,
                  index: 1),
              SizedBox(width: 51.sp),
              const BottomBarItem(
                  activeIcon: Icons.people,
                  inactiveIcon: Icons.people_outline,
                  index: 2),
              const BottomBarItem(
                  activeIcon: Icons.person,
                  inactiveIcon: Icons.person_outline,
                  index: 3),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                AppBloc.authenticateBloc.add(LogoutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
