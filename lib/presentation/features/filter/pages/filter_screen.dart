import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/app_button_widget.dart';
import '../widgets/pick_select_widget.dart';

enum FilterScreenType {
  student,
  teacher,
}

class FilterScreen extends StatelessWidget {
  final type = FilterScreenType.student;
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Your partners'),
                        Row(
                          children: [
                            Expanded(
                              child: AppButtonWidget(
                                  label: 'Student',
                                  onPressed: () {},
                                  width: 42.w),
                            ),
                            SizedBox(width: 12.sp),
                            Expanded(
                              child: AppButtonWidget(
                                  label: 'Teacher',
                                  onPressed: () {},
                                  width: 42.w),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.sp),
                        const Text('Speaking'),
                        PickSelectWidget(
                            title: 'Enter speaking',
                            onTap: () {
                              AppNavigator().push(RouteConstants.filterSelect);
                            }),
                        const Text('Language'),
                        PickSelectWidget(
                            title: 'Enter language',
                            onTap: () {
                              AppNavigator().push(RouteConstants.filterSelect);
                            }),
                        const Spacer(),
                        AppButtonWidget(
                            label: 'Search',
                            onPressed: () {
                              AppNavigator().push(RouteConstants.filterResult);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
