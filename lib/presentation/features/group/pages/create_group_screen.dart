import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/app_button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New group'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: 6.sp, bottom: 1.h, left: 12.sp, right: 12.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Name of the group'),
              const SizedBox(height: 8),
              const TextfieldWidget(),
              const SizedBox(height: 16),
              const Text('Description'),
              const SizedBox(height: 8),
              const TextfieldWidget(),
              const Spacer(),
              AppButtonWidget(
                label: const Text('Create group'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
