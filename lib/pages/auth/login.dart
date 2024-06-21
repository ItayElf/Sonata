import 'package:flutter/material.dart';
import 'package:sonata/pages/auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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

  List<Widget> getInputFields() => [
        getTextField(
          "Email",
          Icons.mail_outline,
          emailController,
          autofillHint: AutofillHints.email,
        ),
        const SizedBox(height: 40),
        getTextField(
          "Password",
          Icons.lock_outline,
          passwordController,
          autofillHint: AutofillHints.password,
          isSecret: true,
        ),
        const SizedBox(height: 20),
      ];

  TextField getTextField(
    String title,
    IconData icon,
    TextEditingController controller, {
    String? autofillHint,
    bool isSecret = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isSecret,
      autofillHints: autofillHint != null ? [autofillHint] : null,
      decoration: InputDecoration(
        hintText: title,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Future onSubmit() {
    return Future.delayed(const Duration(seconds: 2));
  }

  Future onTransition() {
    return Future.delayed(const Duration(seconds: 2));
  }
}
