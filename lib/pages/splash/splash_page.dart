import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonata/communication/auth.dart';
import 'package:sonata/models/full_user.dart';
import 'package:sonata/pages/responsive_page.dart';
import 'package:sonata/pages/splash/desktop/desktop_splash_page.dart';
import 'package:sonata/pages/splash/mobile/mobile_splash_page.dart';
import 'package:sonata/state/global_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FullUser? _user;
  String? _token;

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
      return;
    }
    _token = accessToken;
    final userResult = await getCurrentUser(accessToken);
    if (userResult.isError) {
      return;
    }
    setState(() {
      _user = userResult.data;
    });
  }

  Future onEnd(BuildContext context) async {
    if (_user != null && _token != null) {
      Provider.of<GlobalState>(context, listen: false)
          .initialize(_user!, _token!);
      Navigator.of(context).pushReplacementNamed("/tags");
    } else {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }
}
