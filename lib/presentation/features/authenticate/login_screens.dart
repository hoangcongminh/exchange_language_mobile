import 'package:flutter/material.dart';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: false,
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3.0, color: Colors.grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  color: Theme.of(context).accentColor,
                                ),
                                child: const SizedBox(width: 12, height: 12),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context)
                        //         .pushNamed(RouteList.forgotPassword);
                        //   },
                        //   child: Text(
                        //     'Forgot your Password?',
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodyText1
                        //         .copyWith(
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold,
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ElevatedButton(
		      style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                        child: const Text('Sign in'),
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
