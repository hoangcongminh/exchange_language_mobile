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
              const BottomBarItem(icon: Icons.chat),
              const BottomBarItem(icon: Icons.notifications),
              SizedBox(width: 51.sp),
              const BottomBarItem(icon: Icons.people),
              const BottomBarItem(icon: Icons.person),
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
