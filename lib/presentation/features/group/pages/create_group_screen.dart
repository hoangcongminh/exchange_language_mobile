import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/app_button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createGroup),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: 6.sp, bottom: 1.h, left: 12.sp, right: 12.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.nameOfTheGroup),
              const SizedBox(height: 8),
              const TextfieldWidget(),
              const SizedBox(height: 16),
              Text(l10n.description),
              const SizedBox(height: 8),
              const TextfieldWidget(
                minLines: 10,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
              ),
              const Spacer(),
              AppButtonWidget(
                label: Text(l10n.createGroup),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
