import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/app_button_widget.dart';
import '../../../widgets/avatar_widget.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Card(
        shadowColor: const Color(0xFF828282),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            children: [
              ListTile(
                leading: AvatarWidget(height: 30.sp, width: 30.sp),
                title: const Text('Language exchange partners in English'),
                subtitle: const Text('James'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: const Text(
                    'Discuss good topics to talk about, strategies for making the exchange more fun and rewarding and everything else related'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Row(
                  children: [
                    const Icon(Icons.people),
                    const Text('34'),
                    SizedBox(width: 10.sp),
                    const Spacer(),
                    AppButtonWidget(
                      label: Text(l10n.join),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
