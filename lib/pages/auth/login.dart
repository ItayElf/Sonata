import 'package:flutter/material.dart';
import 'package:sonata/pages/auth/auth.dart';

class LoginPage extends AuthPage {
  const LoginPage({super.key});

  @override
  List<Widget> getInputFields() {
    return [];
  }

  @override
  Future onSubmit() async {
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future onTransition() {
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  String get buttonText => "LOG IN";

  @override
  String get underlineText => "Don't have an account? ";
}
