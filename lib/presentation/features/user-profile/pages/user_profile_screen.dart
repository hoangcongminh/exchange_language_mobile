import 'package:exchange_language_mobile/presentation/common-bloc/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AppBloc.authenticateBloc.add(LogoutEvent());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('User Profile'),
      ),
    );
  }
}
