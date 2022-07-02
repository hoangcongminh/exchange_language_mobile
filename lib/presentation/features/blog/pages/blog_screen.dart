import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../routes/app_pages.dart';
import '../widgets/blog_item.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return const Chip(
                    label: Text('English'),
                  );
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemBuilder: (context, index) => BlogItem(
                  onTap: () => AppNavigator().push(RouteConstants.blogDetail),
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
