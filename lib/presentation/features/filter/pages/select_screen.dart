import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/search_box.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: Column(
        children: [
          SizedBox(height: 8.sp),
          const SearchBox(),
        ],
      ),
    );
  }
}
