import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

abstract class AppFonts {
  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: appWhiteColor,
  );
  static const textStyle13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: appBlueColor,
  );
  static const textStyle13White = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: appWhiteColor,
  );
}
