import 'dart:io';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/language.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/custom_image_picker.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../filter/bloc/filter_bloc.dart';
import '../../filter/widgets/pick_select_widget.dart';
import '../bloc/authenticate_bloc.dart';
import '../widgets/auth_button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  final String email;
  const RegisterScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _imagePicked;
  final _formKey = GlobalKey<FormState>();
  bool _visiblePass = false;
  bool _visibleRetypePass = false;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

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
    const SizedBox space = SizedBox(height: 10);
    return Scaffold(
      body: BlocConsumer<AuthenticateBloc, AuthenticateState>(
          listener: (context, state) {
        if (state is AuthenticationFail) {
          showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                  errorTitle: 'Register error', errorMessage: state.error));
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
                          : const SizedBox(
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
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
                          Stack(
                            children: [
                              TextfieldWidget(
                                keyboardType: TextInputType.text,
                                labelText: l10n.password,
                                hintText: l10n.enterPassword,
                                obscureText: !_visiblePass,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.trim().length < 6) {
                                    return 'Password is at least 6 characters';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _visiblePass = !_visiblePass;
                                      });
                                    },
                                    icon: const Icon(Icons.remove_red_eye)),
                              ),
                            ],
                          ),
                          space,
                          Stack(
                            children: [
                              TextfieldWidget(
                                keyboardType: TextInputType.text,
                                labelText: l10n.retypePassword.toUpperCase(),
                                hintText: l10n.retypePassword,
                                obscureText: !_visiblePass,
                                controller: _retypePasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.trim().length < 6) {
                                    return 'Password is at least 6 characters';
                                  } else if (value.trim() !=
                                      _passwordController.text) {
                                    return 'Password is not match';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _visibleRetypePass =
                                            !_visibleRetypePass;
                                      });
                                    },
                                    icon: const Icon(Icons.remove_red_eye)),
                              ),
                            ],
                          ),
                          space,
                          PickSelectWidget(
                            title: 'Enter speaking',
                            selectedLanguages: speaking,
                            onTap: () => onTapSelectLanguage(true),
                          ),
                          PickSelectWidget(
                            title: 'Enter learning',
                            selectedLanguages: learning,
                            onTap: () => onTapSelectLanguage(false),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: AuthButtonWidget(
                              label: l10n.signUp,
                              onPressed: () {
                                AppBloc.authenticateBloc.add(RegisterEvent(
                                  email: widget.email,
                                  fullName: _nameController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  avatar: _imagePicked,
                                  speak: speaking,
                                  learn: learning,
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state is Authenticating) const LoadingWidget()
          ],
        );
      }),
    );
  }
}
