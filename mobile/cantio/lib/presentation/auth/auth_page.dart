import 'package:cantio/data/providers/auth_provider.dart';
import 'package:cantio/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  final AuthProvider authProvider;
  const AuthPage({Key? key, required this.authProvider}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<String?>? _authUser(LoginData data) async {
    await widget.authProvider
        .login(email: data.name, password: data.password);
    return null;
  }

  Future<String?>? _signupUser(SignupData data) async {
    await widget.authProvider
        .registerUser(email: data.name!, password: data.password!);

    return null;
  }

  Future<String>? _recoverPassword(String name) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "Cantio",
      theme:
          LoginTheme(pageColorLight: Colors.blue, pageColorDark: Colors.black),
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: (String name) {},
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
    );
  }
}
