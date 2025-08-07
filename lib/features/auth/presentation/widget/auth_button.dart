import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appWhiteColor,
                  minimumSize: Size(324, 57),
                ),
                onPressed:onPressed,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: appBlueColor,
                  ),
                ),
              );
  }
}