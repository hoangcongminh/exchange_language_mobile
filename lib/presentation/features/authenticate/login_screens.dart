import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/textfield_widget.dart';

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
    final SizedBox space = SizedBox(height: 10);
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
                      labelText: 'EMAIL ADDRESS',
                      hintText: 'Enter Email',
                      controller: _editingControllerEmail,
                    ),
                    space,
                    Stack(
                      children: [
                        TextfieldWidget(
                          keyboardType: TextInputType.text,
                          labelText: 'PASSWORD',
                          hintText: 'Enter password',
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
                              icon: Icon(Icons.remove_red_eye)),
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
                          child: Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                    ),
                    space,
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        child: Text(AppLocalizations.of(context)!.login),
                        onPressed: () {},
                      ),
                    ),
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
