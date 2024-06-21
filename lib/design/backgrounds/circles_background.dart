import 'package:flutter/material.dart';

class CirclesBackground extends StatelessWidget {
  const CirclesBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ellipseAt(
              Theme.of(context).colorScheme.primaryContainer,
              left: -56,
              top: -200,
            ),
            ellipseAt(
              Theme.of(context).colorScheme.primary,
              left: -178,
              top: -111,
            ),
            ellipseAt(
              Theme.of(context).colorScheme.primary,
              right: -195,
              bottom: -100,
            ),
            ellipseAt(
              Theme.of(context).colorScheme.primaryContainer,
              right: -62,
              bottom: -183,
            ),
            Center(
              child: child,
            )
          ],
        ),
      ),
    );
  }

  Widget ellipseAt(
    Color color, {
    double? top,
    double? right,
    double? bottom,
    double? left,
  }) =>
      Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: Container(
          width: 242,
          height: 242,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(242)),
            color: color,
          ),
        ),
      );
}
