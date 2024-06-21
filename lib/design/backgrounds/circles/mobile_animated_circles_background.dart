import 'package:flutter/material.dart';

class MobileAnimatedCirclesBackground extends StatefulWidget {
  const MobileAnimatedCirclesBackground({
    super.key,
    this.child,
    required this.duration,
  });

  final Duration duration;
  final Widget? child;

  @override
  State<MobileAnimatedCirclesBackground> createState() =>
      _MobileAnimatedCirclesBackgroundState();
}

class _MobileAnimatedCirclesBackgroundState
    extends State<MobileAnimatedCirclesBackground> {
  double size = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 1))
        .then((value) => setState(() {
              size = 242;
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
          curve: Curves.ease,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(242)),
            color: color,
          ),
        ),
      );
}
