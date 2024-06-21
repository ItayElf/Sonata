import 'package:flutter/material.dart';
import 'package:sonata/communication/auth.dart';
import 'package:sonata/pages/auth/auth_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      buttonText: "CREATE ACCOUNT",
      underlineText: "Already have an account? ",
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
          "Username",
          Icons.person_outline,
          usernameController,
          autofillHint: AutofillHints.username,
        ),
        const SizedBox(height: 40),
        getTextField(
          "Password",
          Icons.lock_outline,
          passwordController,
          autofillHint: AutofillHints.password,
          isSecret: true,
        ),
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
    final username = usernameController.text;
    final password = passwordController.text;
    final result = await registerRequest(email, username, password);
    setState(() {
      error = result.error;
    });
  }

  Future onTransition(BuildContext context) {
    return Navigator.of(context).pushReplacementNamed("/login");
  }
}
