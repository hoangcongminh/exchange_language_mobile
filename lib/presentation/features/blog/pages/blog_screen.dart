import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/blog_item.dart';

class BlogScreen extends StatefulWidget {
  final VoidCallback onTapAdd;
  const BlogScreen({Key? key, required this.onTapAdd}) : super(key: key);

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
                  return Chip(
                    label: Text('English'),
                  );
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemBuilder: (context, index) => const BlogItem(),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: widget.onTapAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
