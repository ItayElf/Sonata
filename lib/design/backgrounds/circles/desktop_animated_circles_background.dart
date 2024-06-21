import 'package:flutter/material.dart';

class DesktopAnimatedCirclesBackground extends StatefulWidget {
  const DesktopAnimatedCirclesBackground(
      {super.key, this.child, required this.duration});

  final Duration duration;
  final Widget? child;

  @override
  State<DesktopAnimatedCirclesBackground> createState() =>
      _DesktopAnimatedCirclesBackgroundState();
}

class _DesktopAnimatedCirclesBackgroundState
    extends State<DesktopAnimatedCirclesBackground> {
  double size = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 1))
        .then((value) => setState(() {
              size = 737;
            }));
  }

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
              child: widget.child,
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
        child: AnimatedContainer(
          width: size,
          height: size,
          duration: widget.duration,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(737)),
            color: color,
          ),
        ),
      );
}
