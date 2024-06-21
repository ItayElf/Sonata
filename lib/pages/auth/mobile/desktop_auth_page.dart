import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonata/components/future_elevated_button.dart';
import 'package:sonata/design/backgrounds/circles/desktop_circles_background.dart';

class DesktopAuthPage extends StatelessWidget {
  const DesktopAuthPage({
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
    return DesktopCirclesBackground(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sonata",
              style: GoogleFonts.greatVibes(fontSize: 143, letterSpacing: -1.5),
            ),
            const SizedBox(height: 36),
            Form(
              child: AutofillGroup(
                child: Column(
                  children: [
                    ...inputFields,
                    const SizedBox(height: 36),
                    getButton(context),
                  ],
                ),
              ),
            ),
            if (errorText != null) const SizedBox(height: 8),
            if (errorText != null) getErrorText(context),
            const SizedBox(height: 36),
            getUnderlineLink(context),
          ],
        ),
      ),
    );
  }

  Text getErrorText(BuildContext context) {
    return Text(
      errorText!,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red),
    );
  }

  RichText getUnderlineLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: underlineText,
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(
            text: "Click Here!",
            recognizer: TapGestureRecognizer()..onTap = onTransition,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
          )
        ],
      ),
    );
  }

  FutureElevatedButton getButton(BuildContext context) {
    return FutureElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          letterSpacing: 1.25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
