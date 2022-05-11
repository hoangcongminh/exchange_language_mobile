import 'package:exchange_language_mobile/common/helpers/utils/validator_utils.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/auth_button_widget.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/textfield_widget.dart';
import 'package:exchange_language_mobile/presentation/features/verification/bloc/verification_bloc.dart';
import 'package:exchange_language_mobile/presentation/widgets/error_dialog_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputEmailScreen extends StatefulWidget {
  final bool isForgotPassword;
  const InputEmailScreen({Key? key, required this.isForgotPassword})
      : super(key: key);

  @override
  State<InputEmailScreen> createState() => _InputEmailScreenState();
}

class _InputEmailScreenState extends State<InputEmailScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _onSubmit() async {
    final _isValid = _formKey.currentState!.validate();
    if (_isValid) {
      AppBloc.verificationBloc.add(SendOTPEvent(
          email: _emailController.text,
          isForgotPassword: widget.isForgotPassword));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const SizedBox space = SizedBox(height: 10);
    return BlocConsumer<VerificationBloc, VerificationState>(
      listener: (context, state) {
        if (state is SendOtpFail) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                errorTitle: 'Send otp error', errorMessage: state.error),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CupertinoNavigationBarBackButton(
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
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
                                    keyboardType: TextInputType.text,
                                    labelText: 'EMAIL',
                                    hintText: l10n.enterEmail,
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      } else if (!ValidatorUtils.isEmail(
                                          value)) {
                                        return 'Email is invalid';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  space,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: AuthButtonWidget(
                                      label: widget.isForgotPassword
                                          ? l10n.confirm
                                          : l10n.signUp,
                                      onPressed: () {
                                        final _isValid =
                                            _formKey.currentState!.validate();
                                        if (_isValid) {
                                          _onSubmit();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!widget.isForgotPassword)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    l10n.alreadyHaveAccount,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        l10n.login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (state is VerificationLoading) const LoadingWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
