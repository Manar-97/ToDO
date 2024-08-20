import 'package:flutter/material.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';

abstract class AppStyles {
  static const TextStyle appBarStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  static const TextStyle bottomSheetTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const TextStyle appBarDarkStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle normalGreyTextStyle = TextStyle(
      fontSize: 14, color: AppColors.grey, fontWeight: FontWeight.w500);
  static const TextStyle selectedCalenderDayStyle =
      TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle unSelectedCalenderDayStyle = TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
}
