import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
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

class SelectLanguageScreen extends StatefulWidget {
  final List<Language> selectedLanguage;

  const SelectLanguageScreen({Key? key, required this.selectedLanguage})
      : super(key: key);

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  final List<Language> searchList = [];
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
          SearchBox(
            onChanged: (text) {
              final state = AppBloc.filterBloc.state as SelectLanguageState;
              setState(() {
                searchList.clear();
                if (text != "") {
                  for (var i = 0; i < state.languages.length; i++) {
                    if (state.languages[i].name.toLowerCase().contains(text)) {
                      searchList.add(state.languages[i]);
                    }
                  }
                }
              });
            },
          ),
          SizedBox(
            height: 8.sp,
          ),
          if (widget.selectedLanguage.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
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
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          SizedBox(
            height: 8.sp,
          ),
          BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              if (state is SelectLanguageState) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchList.isEmpty
                        ? state.languages.length
                        : searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final languages =
                          searchList.isEmpty ? state.languages : searchList;
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
                                      '${AppConstants.baseImageUrl}${languages[index].thumbnail.src}'),
                              title: Text(
                                languages[index].name,
                                style: TextStyle(
                                  color: widget.selectedLanguage
                                          .contains(languages[index])
                                      ? Theme.of(context).primaryColor
                                      : null,
                                ),
                              ),
                              trailing: Checkbox(
                                value: widget.selectedLanguage
                                    .contains(languages[index]),
                                onChanged: (value) {
                                  setState(() {
                                    if (widget.selectedLanguage
                                        .contains(languages[index])) {
                                      widget.selectedLanguage
                                          .remove(languages[index]);
                                    } else {
                                      widget.selectedLanguage
                                          .add(languages[index]);
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
