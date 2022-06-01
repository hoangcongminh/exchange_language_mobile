import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/language.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/search_box.dart';
import '../bloc/filter_bloc.dart';

class SelectScreen extends StatefulWidget {
  final List<Language> selectedLanguage;

  const SelectScreen({Key? key, required this.selectedLanguage})
      : super(key: key);

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        actions: [
          IconButton(
            onPressed: () {
              AppNavigator().pop(arguments: widget.selectedLanguage);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.sp),
          const SearchBox(),
          SizedBox(
            height: 30.sp,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.selectedLanguage.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.sp),
                  width: 70.sp,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      widget.selectedLanguage[index].name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              if (state is SelectLanguageState) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.languages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Column(
                          children: [
                            ListTile(
                              leading: AvatarWidget(
                                  shape: BoxShape.rectangle,
                                  height: 20.sp,
                                  width: 20.sp,
                                  imageUrl:
                                      '${AppConstants.baseImageUrl}${state.languages[index].thumbnail.src}'),
                              title: Text(
                                state.languages[index].name,
                                style: TextStyle(
                                  color: widget.selectedLanguage
                                          .contains(state.languages[index])
                                      ? Theme.of(context).primaryColor
                                      : null,
                                ),
                              ),
                              trailing: Checkbox(
                                value: widget.selectedLanguage
                                    .contains(state.languages[index]),
                                onChanged: (value) {
                                  setState(() {
                                    if (widget.selectedLanguage
                                        .contains(state.languages[index])) {
                                      widget.selectedLanguage
                                          .remove(state.languages[index]);
                                    } else {
                                      widget.selectedLanguage
                                          .add(state.languages[index]);
                                    }
                                  });
                                },
                                shape: const CircleBorder(),
                              ),
                            ),
                            Divider(thickness: 1.sp)
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const LoadingWidget();
              }
            },
          )
        ],
      ),
    );
  }
}
