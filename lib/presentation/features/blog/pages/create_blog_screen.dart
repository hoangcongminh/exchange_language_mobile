import 'package:flutter/material.dart';

class CreateBlogScreen extends StatelessWidget {
  const CreateBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New blog')),
    );
  }
}
