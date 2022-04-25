import 'package:exchange_language_mobile/presentation/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/no_data.jpg',
                width: 40.w,
                height: 80.w,
              ),
              Text(
                'User not found...',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppButtonWidget(label: 'Search again', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
