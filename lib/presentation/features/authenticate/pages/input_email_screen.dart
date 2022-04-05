import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/common/helpers/utils/validator_utils.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/auth_button_widget.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class InputEmailScreen extends StatefulWidget {
  const InputEmailScreen({Key? key}) : super(key: key);

  @override
  State<InputEmailScreen> createState() => _InputEmailScreenState();
}

class _InputEmailScreenState extends State<InputEmailScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const SizedBox space = SizedBox(height: 10);
    return Scaffold(
      body: Center(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: AuthButtonWidget(
                        label: l10n.signUp,
                        onPressed: () {
                          final _isValid = _formKey.currentState!.validate();
                          if (_isValid) {
                            Navigator.of(context).pushNamed(
                                RouteConstants.verification,
                                arguments: _emailController.text.trim());
                          }
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
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Log in',
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
    );
  }
}
