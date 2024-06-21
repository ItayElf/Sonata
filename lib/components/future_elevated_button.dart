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
      onPressed: isDisabled ? null : onAsyncPressed,
      style: widget.style,
      child: widget.child,
    );
  }

  void onAsyncPressed() async {
    setState(() {
      isDisabled = true;
    });
    await widget.onPressed!();
    setState(() {
      isDisabled = false;
    });
  }
}
