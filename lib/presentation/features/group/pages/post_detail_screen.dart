import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widget/post_item.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PostHeader(),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          children: [
            const PostItem(
              isPostDetail: true,
            ),
            Divider(
              thickness: 1.sp,
            )
          ],
        ),
      ),
    );
  }
}
