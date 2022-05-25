import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/app_button_widget.dart';
import '../../../widgets/avatar_widget.dart';
import '../bloc/filter_bloc.dart';

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              if (state is FilterResult) {
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = state.users[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.sp),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  AvatarWidget(
                                    height: 40.sp,
                                    width: 40.sp,
                                    imageUrl:
                                        'https://exchangelanguage.tk${user.avatar.src}',
                                  ),
                                  Column(
                                    children: [
                                      Text(user.fullname),
                                      Text('Location'),
                                      Text('Location'),
                                      Text('Location'),
                                      // Expanded(
                                      //   child: GridView.count(
                                      //     primary: false,
                                      //     padding: const EdgeInsets.all(20),
                                      //     crossAxisSpacing: 2.sp,
                                      //     mainAxisSpacing: 2.sp,
                                      //     crossAxisCount: 2,
                                      //     children: [],
                                      //   ),
                                      // )
                                    ],
                                  )
                                ],
                              ),
                              const Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum...'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Column(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
