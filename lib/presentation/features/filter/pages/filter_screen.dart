import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/presentation/widgets/app_button_widget.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
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
        child: const Icon(Icons.close, color: Colors.black),
        onPressed: () {
          AppNavigator().pop();
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
                width: 40.w,
                height: 40.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your partners'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtonWidget(
                            label: 'Student', onPressed: () {}, width: 42.w),
                        AppButtonWidget(
                            label: 'Teacher', onPressed: () {}, width: 42.w),
                      ],
                    ),
                    Text('Location'),
                    TextFormField(),
                    Text('Learning'),
                    TextFormField(),
                    Text('Speaking'),
                    TextFormField(),
                    AppButtonWidget(
                        label: 'Search',
                        onPressed: () {
                          AppNavigator().push(RouteConstants.filterResult);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
