import 'package:exchange_language_mobile/presentation/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationShimmerItem extends StatelessWidget {
  const NotificationShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppShimmer.round(size: 40.sp),
          SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(height: 20.sp, width: 165.w),
                SizedBox(height: 2.sp),
                AppShimmer(height: 13.sp, width: 15.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
