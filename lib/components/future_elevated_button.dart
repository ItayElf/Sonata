import 'package:flutter/material.dart';

class FutureElevatedButton extends StatefulWidget {
  const FutureElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  final Future Function()? onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  State<FutureElevatedButton> createState() => _FutureElevatedButtonState();
}

class _FutureElevatedButtonState extends State<FutureElevatedButton> {
  late bool isDisabled;

  @override
  void initState() {
    super.initState();
    isDisabled = widget.onPressed == null;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : () => onAsyncPressed(context),
      style: widget.style,
      child: widget.child,
    );
  }

  void onAsyncPressed(BuildContext context) async {
    setState(() {
      isDisabled = true;
    });
    try {
      await widget.onPressed!();
    } catch (e) {
      print("Error: $e");
      debugPrintStack();
    }
    if (context.mounted) {
      setState(() {
        isDisabled = false;
      });
    }
  }
}
