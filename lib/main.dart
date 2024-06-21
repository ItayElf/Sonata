import 'package:flutter/material.dart';
import 'package:sonata/design/theme.dart';
import 'package:sonata/pages/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonata',
      theme: getThemeData(),
      initialRoute: initialRoute,
      routes: appRoutes,
    );
  }
}
