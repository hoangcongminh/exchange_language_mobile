import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/shimmer/app_shimmer.dart';

class ChatShimmerItem extends StatelessWidget {
  const ChatShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: Row(
              children: [
                AppShimmer.round(size: 40.sp),
                SizedBox(width: 12.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 20.sp,
                        alignment: Alignment.centerLeft,
                        child: AppShimmer(width: 30.w, height: 13.sp),
                      ),
                      SizedBox(height: 3.5.sp),
                      Container(
                        height: 20.sp,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 20.sp,
                          alignment: Alignment.centerLeft,
                          child: AppShimmer(width: 50.w, height: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.sp),
                AppShimmer(width: 9.sp, height: 35.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
