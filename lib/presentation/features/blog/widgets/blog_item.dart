import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 8.sp),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          SizedBox(width: 10.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem...'),
                SizedBox(height: 8.sp),
                Text('May 22 2017'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
