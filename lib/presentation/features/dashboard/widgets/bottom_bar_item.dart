import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_bloc.dart';
import '../bloc/dashboard_bloc.dart';

class BottomBarItem extends StatelessWidget {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final int index;
  // ignore: prefer_const_constructors_in_immutables
  BottomBarItem(
      {Key? key,
      required this.index,
      required this.activeIcon,
      required this.inactiveIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        onPressed: () =>
            AppBloc.dashboardBloc.add(OnChangeIndexEvent(index: index)),
        icon: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
          int _currentIndex = state.index;
          return Icon(
            _currentIndex == index ? activeIcon : inactiveIcon,
            size: 21.sp,
            color:
                _currentIndex == index ? Theme.of(context).primaryColor : null,
          );
        }),
      ),
    );
  }
}
