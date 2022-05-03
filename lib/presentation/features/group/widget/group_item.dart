import 'package:exchange_language_mobile/presentation/widgets/app_button_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: AvatarWidget(height: 30.sp, width: 30.sp),
            title: Text('Group'),
            subtitle: Text('Group description'),
          ),
          // Expanded(
          //   child: Row(
          //     children: [
          //       Icon(Icons.people),
          //       Text('32'),
          //       Icon(Icons.comment),
          //       Text('4'),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
