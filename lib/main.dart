import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sonata/design/theme.dart';
import 'package:sonata/pages/router.dart';
import 'package:sonata/state/global_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: const MyApp(),
    ),
  );
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
