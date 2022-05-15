import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_bloc.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../bloc/authenticate_bloc.dart';
import '../widgets/auth_button_widget.dart';
import '../widgets/textfield_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String email;
  const ForgotPasswordScreen({Key? key, required this.email}) : super(key: key);

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
    final l10n = context.l10n;
    SizedBox space = SizedBox(height: 10.sp);
    return BlocConsumer<AuthenticateBloc, AuthenticateState>(
      listener: (context, state) {
        if (state is AuthenticationFail) {
          showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                  errorTitle: 'Login error', errorMessage: state.error));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
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
                                    } else if (_passwordController.text !=
                                        value) {
                                      return 'Password does not match';
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
                                label: l10n.resetPassword,
                                onPressed: () async {
                                  AppBloc.authenticateBloc.add(
                                    ResetPasswordEvent(
                                      email: widget.email,
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
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
          ),
        );
      },
    );
  }
}
