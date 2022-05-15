import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/blog_item.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => const BlogItem(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
