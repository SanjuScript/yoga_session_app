import 'package:flutter/material.dart';
import 'package:yoga_session_app/animation/page_animation/custom_animation.dart';
import 'package:yoga_session_app/theme/text_theme.dart';

class CustomTheme {
  static final lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.deepPurpleAccent),
      ),
      textTheme: TextTheme(
        displayLarge:
            PerfectTypogaphy.bold.copyWith(fontSize: 32, color: Colors.black87),
        displayMedium:
            PerfectTypogaphy.bold.copyWith(fontSize: 28, color: Colors.black87),
        bodyLarge: PerfectTypogaphy.regular
            .copyWith(fontSize: 16, color: Colors.black87),
        bodyMedium: PerfectTypogaphy.regular
            .copyWith(fontSize: 14, color: Colors.black87),
        bodySmall:
            PerfectTypogaphy.regular.copyWith(fontSize: 12, color: Colors.grey),
        labelLarge:
            PerfectTypogaphy.bold.copyWith(fontSize: 16, color: Colors.white),
        titleLarge:
            PerfectTypogaphy.bold.copyWith(fontSize: 24, color: Colors.black87),
        titleMedium:
            PerfectTypogaphy.bold.copyWith(fontSize: 20, color: Colors.black87),
        titleSmall:
            PerfectTypogaphy.bold.copyWith(fontSize: 18, color: Colors.black87),
        headlineLarge: PerfectTypogaphy.regular
            .copyWith(fontSize: 22, color: Colors.black87),
        headlineMedium: PerfectTypogaphy.regular
            .copyWith(fontSize: 20, color: Colors.black87),
        headlineSmall: PerfectTypogaphy.regular
            .copyWith(fontSize: 18, color: Colors.black87),
        labelMedium:
            PerfectTypogaphy.bold.copyWith(fontSize: 16, color: Colors.black87),
        labelSmall:
            PerfectTypogaphy.bold.copyWith(fontSize: 14, color: Colors.black87),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          textStyle: PerfectTypogaphy.bold.copyWith(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.teal.shade50,
          foregroundColor: Colors.teal,
          textStyle: PerfectTypogaphy.bold.copyWith(fontSize: 14),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.deepPurpleAccent,
          side: const BorderSide(color: Colors.deepPurpleAccent),
          textStyle: PerfectTypogaphy.bold.copyWith(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.teal,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xffeff3fc),
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedLabelStyle: PerfectTypogaphy.regular.copyWith(
            letterSpacing: 0.5,
            color: Colors.black87,
          )),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CustomPageTransition(),
        TargetPlatform.iOS: CustomPageTransition(),
      }));
}
