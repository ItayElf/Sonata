import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonata/pages/responsive_page.dart';
import 'package:sonata/pages/splash/desktop/desktop_splash_page.dart';
import 'package:sonata/pages/splash/mobile/mobile_splash_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool shouldLogin = false;

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
    final preferences = await SharedPreferences.getInstance();
    final accessToken = preferences.getString("access_token");
    if (accessToken == null) {
      setState(() {
        shouldLogin = true;
      });
      return;
    }
    return;
  }

  Future onEnd(BuildContext context) async {
    if (shouldLogin) {
      Navigator.of(context).pushReplacementNamed("/login");
    } else {
      print("Already logged in");
    }
  }
}
