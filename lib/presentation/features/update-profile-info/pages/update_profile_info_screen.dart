import 'dart:io';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/constants.dart';
import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../domain/entities/language.dart';
import '../../../../domain/entities/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/avatar_widget.dart';
import '../../../widgets/custom_image_picker.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/textfield_widget.dart';
import '../../authenticate/widgets/auth_button_widget.dart';
import '../../filter/bloc/filter_bloc.dart';
import '../../filter/widgets/pick_select_widget.dart';
import '../bloc/update_profile_info_bloc.dart';

class UpdateProfileInfoScreen extends StatefulWidget {
  final User user;
  const UpdateProfileInfoScreen({Key? key, required this.user})
      : super(key: key);

  @override
  State<UpdateProfileInfoScreen> createState() =>
      _UpdateProfileInfoScreenState();
}

class _UpdateProfileInfoScreenState extends State<UpdateProfileInfoScreen> {
  File? _imagePicked;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _introductionController = TextEditingController();

  late List<Language> learning;
  late List<Language> speaking;

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
    const SizedBox space = SizedBox(height: 10);
    _nameController.text = widget.user.fullname;
    _introductionController.text = widget.user.introduction ?? '';
    learning = widget.user.learningLanguage ?? [];
    speaking = widget.user.speakingLanguage ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.updateInfo),
      ),
      body: BlocConsumer<UpdateProfileInfoBloc, UpdateProfileInfoState>(
          listener: (context, state) {
        if (state is UpdateProfileInfoFailure) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              errorTitle: 'Update profile error',
              errorMessage: state.message,
            ),
          );
        } else if (state is UpdateProfileInfoSuccess) {
          AppNavigator().pop();
          // AppBloc.authenticateBloc.add(RefreshTokenEvent());
          // AppBloc.blogBloc.add(FetchBlogsEvent());
          AppBloc.initialHomeBloc();
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        CustomImagePicker().openImagePicker(
                            context: context,
                            handleFinish: (file) {
                              setState(() {
                                _imagePicked = file;
                              });
                            });
                      },
                      child: _imagePicked != null
                          ? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: _imagePicked == null
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(_imagePicked!),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            )
                          : AvatarWidget(
                              width: 100,
                              height: 100,
                              imageUrl: widget.user.avatar == null
                                  ? null
                                  : '${AppConstants.baseImageUrl}${widget.user.avatar!.src}'),
                    ),
                    space,
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextfieldWidget(
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'NAME',
                            hintText: l10n.enterEmail,
                            controller: _nameController,
                          ),
                          space,
                          TextfieldWidget(
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'INTRODUCTION',
                            hintText: l10n.enterEmail,
                            controller: _introductionController,
                          ),
                          space,
                          const Text('Speaking'),
                          PickSelectWidget(
                            title: 'Enter speaking',
                            selectedLanguages: speaking,
                            onTap: () => onTapSelectLanguage(true),
                          ),
                          const Text('Learning'),
                          PickSelectWidget(
                            title: 'Enter language',
                            selectedLanguages: learning,
                            onTap: () => onTapSelectLanguage(false),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: AuthButtonWidget(
                              label: 'Update',
                              onPressed: () => AppBloc.updateProfileInfoBloc
                                  .add(UpdateProfileEvent(
                                fullName: _nameController.text.trim(),
                                introduction:
                                    _introductionController.text.trim(),
                                avatar: _imagePicked,
                                currentAvatar: _imagePicked == null
                                    ? UserLocal().getUser()?.avatar?.id
                                    : null,
                                speaking: speaking,
                                learning: learning,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state is UpdateProfileInfoLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (state is UpdateProfileInfoLoading) const LoadingWidget()
          ],
        );
      }),
    );
  }
}
