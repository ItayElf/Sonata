import 'package:flutter/material.dart';
import 'package:sonata/pages/auth/mobile/desktop_auth_page.dart';
import 'package:sonata/pages/auth/mobile/mobile_auth_page.dart';
import 'package:sonata/pages/responsive_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
    required this.buttonText,
    required this.underlineText,
    this.errorText,
    required this.inputFields,
    required this.onSubmit,
    required this.onTransition,
  });

  final String buttonText;
  final String underlineText;
  final String? errorText;
  final List<Widget> inputFields;

  final Future Function() onSubmit;
  final Future Function() onTransition;

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      mobile: MobileAuthPage(
        buttonText: buttonText,
        underlineText: underlineText,
        errorText: errorText,
        inputFields: inputFields,
        onSubmit: onSubmit,
        onTransition: onTransition,
      ),
      desktop: DesktopAuthPage(
        buttonText: buttonText,
        underlineText: underlineText,
        errorText: errorText,
        inputFields: inputFields,
        onSubmit: onSubmit,
        onTransition: onTransition,
      ),
    );
  }
}
