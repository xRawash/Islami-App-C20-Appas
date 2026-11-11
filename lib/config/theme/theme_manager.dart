import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';

class ThemeManager {
  static ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: ColorsManager.gold),
      backgroundColor: ColorsManager.black,
      foregroundColor: ColorsManager.gold,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: ColorsManager.gold,
      ),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorsManager.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.gold,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.black,
      showUnselectedLabels: false,
      showSelectedLabels: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColorsManager.gold, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColorsManager.gold, width: 2),
      ),
      labelStyle: TextStyle(
        color: ColorsManager.ofWhite,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      prefixIconColor: ColorsManager.gold,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 16,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        fontSize: 24,
        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        color: ColorsManager.gold,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        color: ColorsManager.gold,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: ColorsManager.gold),
      backgroundColor: ColorsManager.black,
      foregroundColor: ColorsManager.gold,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: ColorsManager.gold,
      ),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorsManager.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.gold,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.black,
      showUnselectedLabels: false,
      showSelectedLabels: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColorsManager.gold, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColorsManager.gold, width: 2),
      ),
      labelStyle: TextStyle(
        color: ColorsManager.ofWhite,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      prefixIconColor: ColorsManager.gold,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 16,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        fontSize: 24,
        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        color: ColorsManager.gold,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        color: ColorsManager.gold,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
