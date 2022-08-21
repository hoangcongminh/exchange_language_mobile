import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../../widgets/app_button_widget.dart';
import '../bloc/filter_bloc.dart';
import '../widgets/user_result_item.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.result),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              if (state is FilterResult && state.users.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = state.users[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.sp),
                      child: UserResultItem(user: user),
                    );
                  },
                );
              }
              return Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    Image.asset(
                      'assets/images/no_data.jpg',
                      width: 30.w,
                      height: 70.w,
                    ),
                    SizedBox(height: 20.sp),
                    Text(
                      '${l10n.userNotFound}...',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    AppButtonWidget(
                        label: Text(l10n.searchAgain),
                        onPressed: () {
                          AppNavigator().pop();
                        })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
