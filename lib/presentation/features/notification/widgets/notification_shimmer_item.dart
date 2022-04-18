import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.7),
            highlightColor: Colors.grey.withOpacity(0.2),
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.7),
                  highlightColor: Colors.grey.withOpacity(0.2),
                  child: Container(
                    height: 20.sp,
                    width: 165.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                SizedBox(height: 2.sp),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.7),
                  highlightColor: Colors.grey.withOpacity(0.2),
                  child: Container(
                    height: 13.sp,
                    width: 15.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
