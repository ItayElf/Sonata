import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonata/components/future_elevated_button.dart';

import 'package:sonata/design/backgrounds/circles_background.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
    required this.buttonText,
    required this.underlineText,
    required this.inputFields,
    required this.onSubmit,
    required this.onTransition,
  });

  final String buttonText;
  final String underlineText;
  final List<Widget> inputFields;

  final Future Function() onSubmit;
  final Future Function() onTransition;

  @override
  Widget build(BuildContext context) {
    return CirclesBackground(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sonata",
              style: GoogleFonts.greatVibes(fontSize: 89, letterSpacing: -0.5),
            ),
            const SizedBox(height: 36),
            ...inputFields,
            const SizedBox(height: 36),
            getButton(context),
            const SizedBox(height: 36),
            RichText(
              text: TextSpan(
                text: underlineText,
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: "Click Here!",
                    recognizer: TapGestureRecognizer()..onTap = onTransition,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureElevatedButton getButton(BuildContext context) {
    return FutureElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(36),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 14,
          letterSpacing: 1.25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
