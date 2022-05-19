import 'package:exchange_language_mobile/domain/entities/language.dart';
import 'package:exchange_language_mobile/presentation/widgets/avatar_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/search_box.dart';
import '../bloc/filter_bloc.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  final List<Language> _selectedLanguage = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: Column(
        children: [
          SizedBox(height: 8.sp),
          const SearchBox(),
          BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              if (state is SelectLanguageState) {
                return Expanded(
                  child: ListView.builder(
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
                                      'https://exchangelanguage.tk${state.languages[index].thumbnail.src}'),
                              title: Text(state.languages[index].name),
                              trailing: Checkbox(
                                value: _selectedLanguage
                                    .contains(state.languages[index]),
                                onChanged: (value) {
                                  setState(() {
                                    if (_selectedLanguage
                                        .contains(state.languages[index])) {
                                      _selectedLanguage
                                          .remove(state.languages[index]);
                                    } else {
                                      _selectedLanguage
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
