import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../common/helpers/utils/validator_utils.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../bloc/authenticate_bloc.dart';
import '../widgets/auth_button_widget.dart';
import '../../../widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _visiblePass = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      AppBloc.authenticateBloc.add(
        LoginEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final SizedBox space = SizedBox(height: 10.sp);

    return Scaffold(
      body: BlocConsumer<AuthenticateBloc, AuthenticateState>(
        listener: (context, state) {
          if (state is AuthenticationFail) {
            showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                    errorTitle: 'Login error', errorMessage: state.error));
          }
        },
        builder: (context, state) {
          return Stack(
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
                            TextfieldWidget(
                              keyboardType: TextInputType.emailAddress,
                              labelText: 'EMAIL',
                              hintText: l10n.enterEmail,
                              controller: _emailController,
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
                            Padding(
                              padding: EdgeInsets.only(right: 5.sp),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => AppNavigator().push(
                                    RouteConstants.inputEmail,
                                    arguments: {'isForgotPassword': true},
                                  ),
                                  child: Text(l10n.forgotPassword,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                              ),
                            ),
                            space,
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: AuthButtonWidget(
                                label: l10n.login,
                                onPressed: () async {
                                  await _login();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            l10n.dontHaveAccount,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          GestureDetector(
                            onTap: () {
                              AppNavigator().push(
                                RouteConstants.inputEmail,
                                arguments: {'isForgotPassword': false},
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Text(
                                l10n.registerNow,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (state is Authenticating) const LoadingWidget()
            ],
          );
        },
      ),
    );
  }
}
