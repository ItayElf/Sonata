import 'package:flutter/material.dart';
import 'package:sonata/pages/auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return AuthPage(
      buttonText: "LOG IN",
      underlineText: "Don't have an account? ",
      inputFields: getInputFields(),
      onSubmit: onSubmit,
      onTransition: onTransition,
    );
  }

  List<Widget> getInputFields() => [];

  Future onSubmit() {
    return Future.delayed(const Duration(seconds: 2));
  }

  Future onTransition() {
    return Future.delayed(const Duration(seconds: 2));
  }
}
