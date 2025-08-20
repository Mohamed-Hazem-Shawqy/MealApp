import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: appBlueColor),
        onPressed: onPressed,
        child: Text(text, style: AppFonts.textStyle13White),
      ),
    );
  }
}
