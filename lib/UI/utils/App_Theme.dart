import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedIconTheme:
          IconThemeData(color: Color(0xFFC8C9CB), size: 30),
          selectedIconTheme: IconThemeData(size: 35),
          backgroundColor: Colors.white),
      scaffoldBackgroundColor: const Color(0xFFDFECDB),
      colorScheme: ColorScheme.fromSeed(
        onBackground: Colors.white,
        secondaryContainer: Colors.black,
        primaryContainer: Colors.white,
        seedColor: const Color(0xFF82B1FF),
        primary: Colors.blueAccent[100],
        onPrimary: Colors.white,
        background: const Color(0xFFDFECDB),
        secondary: Colors.white,
        onSecondary: const Color(0xFF61E757),
      ),
      textTheme: TextTheme(
          headlineMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: GoogleFonts.inter(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: const Color(0xFFA9A9A9)),
          labelSmall: GoogleFonts.inter(
              fontWeight: FontWeight.normal, fontSize: 15, color: Colors.black),
          bodyMedium: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          )));
  
  static ThemeData dark = ThemeData(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF141922),
          unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
          selectedIconTheme: IconThemeData(size: 35)),
      scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF82B1FF),
          secondaryContainer: Colors.white,
          primaryContainer: Colors.black,
          primary: Colors.blueAccent[100],
          onBackground: const Color(0xFF141922),
          onPrimary: Colors.white,
          background: const Color(0xFF200E32),
          secondary: Colors.white,
          onSecondary: const Color(0xFF61E757)),
      textTheme: TextTheme(
          headlineMedium: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: GoogleFonts.inter(
              fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white),
          labelSmall: GoogleFonts.inter(
              fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white),
          bodyMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          )));}
