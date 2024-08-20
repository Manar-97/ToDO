import 'package:flutter/material.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: Colors.white,
          onPrimary: Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          selectedIconTheme: IconThemeData(size: 33),
          unselectedIconTheme: IconThemeData(size: 33)));

  static ThemeData dark = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.darkBackground,
      canvasColor: Colors.black,
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: Colors.black,
          onPrimary: Colors.black),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 33),
          unselectedIconTheme: IconThemeData(size: 33)));
}
