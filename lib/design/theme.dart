import 'package:flutter/material.dart';

ThemeData getThemeData() => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        primary: const Color(0xFF6750A4),
        primaryContainer: const Color(0xFFEADDFF),
        onPrimary: const Color(0xFFFFFFFF),
        onPrimaryContainer: const Color(0xFF21005D),
      ),
      primaryColor: const Color(0xFF6750A4),
      useMaterial3: true,
    );
