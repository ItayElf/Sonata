import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  final Widget mobile;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return mobile;
        }
        return desktop;
      },
    );
  }
}
