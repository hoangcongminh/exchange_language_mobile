import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  const BottomBarItem({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Icon(icon, size: 21.sp),
      ),
    );
  }
}
