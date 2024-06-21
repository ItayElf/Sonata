import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonata/design/backgrounds/circles/mobile_animated_circles_background.dart';

class MobileSplashPage extends StatefulWidget {
  const MobileSplashPage({
    super.key,
    required this.loadData,
    required this.onEnd,
  });

  final Future Function() loadData;
  final Future Function(BuildContext context) onEnd;

  final Duration duration = const Duration(seconds: 2);

  @override
  State<MobileSplashPage> createState() => _MobileSplashPageState();
}

class _MobileSplashPageState extends State<MobileSplashPage> {
  double size = 0;
  bool loadingFinished = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 1))
        .then((value) => setState(() {
              size = 89;
            }));
    widget.loadData().then((value) => setState(() {
          loadingFinished = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MobileAnimatedCirclesBackground(
      duration: widget.duration,
      child: AnimatedDefaultTextStyle(
        duration: widget.duration,
        curve: Curves.ease,
        onEnd: () => onAnimationFinished(context),
        style: GoogleFonts.greatVibes(
          fontSize: size,
          letterSpacing: -0.5,
          color: Colors.black,
        ),
        child: const Text("Sonata"),
      ),
    );
  }

  void onAnimationFinished(BuildContext context) async {
    if (!loadingFinished) {
      await Future.doWhile(() =>
          Future.delayed(const Duration(milliseconds: 100))
              .then((_) => !loadingFinished));
    }
    if (context.mounted) {
      widget.onEnd(context);
    }
  }
}
