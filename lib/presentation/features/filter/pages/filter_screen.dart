import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../domain/entities/language.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/app_button_widget.dart';
import '../bloc/filter_bloc.dart';
import '../widgets/pick_select_widget.dart';

enum FilterScreenType {
  student,
  teacher,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterScreenType type = FilterScreenType.student;
  List<Language> learning = [];
  List<Language> speaking = [];

  void onTapSelectLanguage(bool isSelectSpeaking) async {
    AppBloc.filterBloc.add(SelectLanguageEvent());
    final result = await AppNavigator().push(RouteConstants.filterSelect,
        arguments: {
          'selectedLanguage': isSelectSpeaking ? speaking : learning
        });
    setState(() {
      if (result is List<Language>) {
        if (isSelectSpeaking) {
          speaking = result;
        } else {
          learning = result;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        key: const Key('homeFab'),
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
            child: BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return Column(
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
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text('Your partners'),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppButtonWidget(
                                        color: type == FilterScreenType.student
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                        label: Text(l10n.learner),
                                        onPressed: () {
                                          setState(() {
                                            type = FilterScreenType.student;
                                          });
                                        },
                                        width: 42.w),
                                  ),
                                  SizedBox(width: 12.sp),
                                  Expanded(
                                    child: AppButtonWidget(
                                        color: type == FilterScreenType.teacher
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                        label: Text(l10n.teacher),
                                        onPressed: () {
                                          setState(() {
                                            type = FilterScreenType.teacher;
                                          });
                                        },
                                        width: 42.w),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.sp),
                              const Text('Speaking'),
                              PickSelectWidget(
                                title: l10n.enterLanguage,
                                selectedLanguages: speaking,
                                onTap: () => onTapSelectLanguage(true),
                              ),
                              const Text('Learning'),
                              PickSelectWidget(
                                title: l10n.enterLanguage,
                                selectedLanguages: learning,
                                onTap: () => onTapSelectLanguage(false),
                              ),
                              const Spacer(),
                              AppButtonWidget(
                                label: Text(l10n.search),
                                onPressed: () {
                                  AppBloc.filterBloc.add(SearchUserEvent(
                                    type == FilterScreenType.teacher ? 1 : 2,
                                    speaking,
                                    learning,
                                  ));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
