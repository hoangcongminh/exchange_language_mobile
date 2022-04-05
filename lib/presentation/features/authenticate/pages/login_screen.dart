import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/common/helpers/utils/validator_utils.dart';
import 'package:exchange_language_mobile/presentation/common-bloc/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/auth_button_widget.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/textfield_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/error_dialog_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final _isValid = _formKey.currentState!.validate();
    if (_isValid) {
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
    const SizedBox space = SizedBox(height: 10);
    return BlocConsumer<AuthenticateBloc, AuthenticateState>(
        listener: (context, state) {
      if (state is AuthenticationFail) {
        showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                errorTitle: 'Login error', errorMessage: state.error));
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(l10n.forgotPassword,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
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
                              )),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Don`t have an account? ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteConstants.inputEmail);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Register Now',
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
        ),
      );
    });
  }
}
