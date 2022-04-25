import 'package:exchange_language_mobile/common/helpers/utils/validator_utils.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/auth_button_widget.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _visiblePass = false;
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizedBox space = SizedBox(height: 10.sp);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        TextfieldWidget(
                          keyboardType: TextInputType.text,
                          labelText: 'PASSWORD',
                          hintText: '',
                          obscureText: !_visiblePass,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!ValidatorUtils.isEmail(value)) {
                              return 'Email is invalid';
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
                          labelText: 'RETYPE PASSWORD',
                          hintText: '',
                          obscureText: !_visiblePass,
                          controller: _retypePasswordController,
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
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: AuthButtonWidget(
                          label: 'Reset Password',
                          onPressed: () async {},
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
