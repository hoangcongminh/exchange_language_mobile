import 'dart:io';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/language.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/pick_image_widget.dart';
import '../../../widgets/textfield_widget.dart';
import '../../filter/bloc/filter_bloc.dart';
import '../../filter/widgets/pick_select_widget.dart';
import '../bloc/create_group_bloc.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  File? _imagePicked;
  List<Language> language = [];
  void onTapSelectLanguage() async {
    AppBloc.filterBloc.add(SelectLanguageEvent());
    final result = await AppNavigator().push(RouteConstants.filterSelect,
        arguments: {'selectedLanguage': language});
    setState(() {
      language = result;
    });
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createGroup),
      ),
      body: BlocConsumer<CreateGroupBloc, CreateGroupState>(
        listener: (context, state) => {
          if (state is CreateGroupFailure)
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                errorTitle: 'Create group error',
                errorMessage: state.message,
              ),
            ),
          if (state is CreateGroupSuccess) AppNavigator().pop()
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 6.sp, bottom: 1.h, left: 12.sp, right: 12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: PickImageWidget(
                          onImagePicked: (file) {
                            setState(() {
                              _imagePicked = file;
                            });
                          },
                          size: 80,
                          icon: Icons.image,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(l10n.nameOfTheGroup),
                      const SizedBox(height: 8),
                      TextfieldWidget(
                        controller: _titleController,
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.description),
                      const SizedBox(height: 8),
                      TextfieldWidget(
                        minLines: 10,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        controller: _descriptionController,
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.language),
                      PickSelectWidget(
                        title: l10n.enterLanguage,
                        selectedLanguages: language,
                        onTap: onTapSelectLanguage,
                      ),
                      const Spacer(),
                      AppButtonWidget(
                        label: Text(l10n.createGroup),
                        onPressed: () =>
                            AppBloc.createGroupBloc.add(CreateNewGroup(
                          thumbnail: _imagePicked,
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          topics: language,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is CreateGroupLoading)
                const Opacity(
                  opacity: 0.8,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
              if (state is CreateGroupLoading) const LoadingWidget()
            ],
          );
        },
      ),
    );
  }
}
