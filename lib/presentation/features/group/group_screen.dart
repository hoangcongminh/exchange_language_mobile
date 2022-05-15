import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'widget/group_item.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => const GroupItem(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
