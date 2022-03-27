import 'package:flutter/material.dart';

import 'package:exchange_language_mobile/common/l10n/l10n.dart';

import '../../../../common/constants/route_constants.dart';
import '../widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _visiblePass = false;
  final _editingControllerEmail = TextEditingController();
  final _editingControllerPass = TextEditingController();

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextfieldWidget(
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'EMAIL',
                      hintText: l10n.enterEmail,
                      controller: _editingControllerEmail,
                    ),
                    space,
                    Stack(
                      children: [
                        TextfieldWidget(
                          keyboardType: TextInputType.text,
                          labelText: l10n.password,
                          hintText: l10n.enterPassword,
                          obscureText: !_visiblePass,
                          controller: _editingControllerPass,
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
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                    ),
                    space,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        child: Text(l10n.login),
                        onPressed: () async {},
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
                    'Don`t have an account? ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteConstants.signUp);
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
    );
  }
}
