import 'package:exchange_language_mobile/presentation/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BlogItem extends StatelessWidget {
  final VoidCallback onTap;
  const BlogItem({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 8.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            const AppImageWidget(height: 100, width: 100),
            SizedBox(width: 10.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem...'),
                  SizedBox(height: 8.sp),
                  const Text('May 22 2017'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
