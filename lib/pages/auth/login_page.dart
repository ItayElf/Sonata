import 'package:flutter/material.dart';
import 'package:sonata/communication/auth.dart';
import 'package:sonata/pages/auth/auth_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

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
      errorText: error,
      inputFields: getInputFields(),
      onSubmit: onSubmit,
      onTransition: () => onTransition(context),
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

  TextFormField getTextField(
    String title,
    IconData icon,
    TextEditingController controller, {
    String? autofillHint,
    bool isSecret = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isSecret,
      onFieldSubmitted: (_) async {
        await onSubmit();
      },
      autofillHints: autofillHint != null ? [autofillHint] : null,
      decoration: InputDecoration(
        hintText: title,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Future onSubmit() async {
    final email = emailController.text;
    final password = passwordController.text;
    final result = await loginRequest(email, password);
    setState(() {
      error = result.error;
    });
  }

  Future onTransition(BuildContext context) {
    return Navigator.of(context).pushReplacementNamed("/register");
  }
}
