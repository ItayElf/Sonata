import 'package:flutter/material.dart';
import 'package:sonata/pages/responsive_page.dart';
import 'package:sonata/pages/splash/desktop/desktop_splash_page.dart';
import 'package:sonata/pages/splash/mobile/mobile_splash_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      mobile: MobileSplashPage(
        loadData: loadData,
        onEnd: onEnd,
      ),
      desktop: DesktopSplashPage(
        loadData: loadData,
        onEnd: onEnd,
      ),
    );
  }

  Future loadData() async {
    return Future.delayed(const Duration(seconds: 10));
  }

  Future onEnd(BuildContext context) async {
    print("hello");
  }
}
