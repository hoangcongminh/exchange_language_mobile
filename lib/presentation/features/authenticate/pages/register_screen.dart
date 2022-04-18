import 'dart:io';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/auth_button_widget.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/textfield_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/custom_image_picker.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const SizedBox space = SizedBox(height: 10);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      /* CustomImagePicker() */
                      /*     .getImage(context: context) */
                      /*     .then((file) { */
                      /*   setState(() { */
                      /*     _imagePicked = File(file.path); */
                      /*   }); */
                      /* }); */
                      CustomImagePicker().openImagePicker(context: context);
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
                                  return 'Password is13 at least 6 characters';
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
                              labelText: l10n.password,
                              hintText: l10n.enterPassword,
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
                                      _visibleRetypePass = !_visibleRetypePass;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
                            ),
                          ],
                        ),
                        space,
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: AuthButtonWidget(
                              label: l10n.signUp,
                              onPressed: () {},
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
