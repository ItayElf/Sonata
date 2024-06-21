import 'package:flutter/material.dart';

class DesktopCirclesBackground extends StatelessWidget {
  const DesktopCirclesBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ellipseAt(
              Theme.of(context).colorScheme.primaryContainer,
              left: -17,
              top: -549,
            ),
            ellipseAt(
              Theme.of(context).colorScheme.primary,
              left: -347,
              top: -340,
            ),
            ellipseAt(
              Theme.of(context).colorScheme.primary,
              right: -444,
              bottom: -212,
            ),
            ellipseAt(
              Theme.of(context).colorScheme.primaryContainer,
              right: -75,
              bottom: -492,
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
          width: 737,
          height: 737,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(737)),
            color: color,
          ),
        ),
      );
}
