import 'package:flutter/material.dart';
//import 'package:flutter_firebase_login/register/register.dart';
import 'package:login_firebase_db/register/bloc/register.dart';
import 'package:login_firebase_db/firebase/user_repository.dart';
import 'package:login_firebase_db/register/register_screen.dart';
//import 'package:login';
//import 'package:login';
class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}