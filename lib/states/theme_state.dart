import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeState extends StateNotifier<ThemeMode> {
  ThemeState() : super(ThemeMode.light);

  void darkMode() {
    state = ThemeMode.dark;
  }

  void lightMode() {
    state = ThemeMode.light;
  }

  void toggleMode() {
    if (state == ThemeMode.dark) {
      lightMode();
    } else {
      darkMode();
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeState, ThemeMode>((ref) {
  return ThemeState();
});

final textTheme = GoogleFonts.poppinsTextTheme(
    ThemeData(brightness: Brightness.light).textTheme);

ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  primaryColor: Colors.blue.shade600,
  textTheme: textTheme,
);

ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  primaryColor: Colors.red,
  textTheme: textTheme,
);
