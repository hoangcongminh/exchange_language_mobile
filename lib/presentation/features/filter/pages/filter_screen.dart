import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        child: Icon(Icons.close, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Looking for your partner...',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.sp),
              const Text(
                'Helping you connect with people \n around the world ',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.sp),
              Image.asset(
                'assets/images/looking_for_partner.jpg',
                width: 50.w,
                height: 50.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
