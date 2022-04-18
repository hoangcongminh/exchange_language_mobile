import 'package:exchange_language_mobile/presentation/common-bloc/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BottomBarItem extends StatelessWidget {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final int index;
  const BottomBarItem(
      {Key? key,
      required this.index,
      required this.activeIcon,
      required this.inactiveIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            AppBloc.dashboardBloc.add(OnChangeIndexEvent(index: index)),
        child: BlocBuilder<DashboardBloc, DashboardState>(
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
