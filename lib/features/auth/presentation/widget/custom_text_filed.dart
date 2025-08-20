import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_fonts.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    this.suffixIcon,
  });
  final TextEditingController? controller;
  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: appWhiteColor,
      style: TextStyle(color: appWhiteColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.textStyle18,
        prefixIcon: prefixIcon,
        fillColor: appBlueColor,
        prefixIconColor: appWhiteColor,
        filled: true,
        suffixIcon: suffixIcon,

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appWhiteColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appWhiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appWhiteColor),
        ),
      ),
    );
  }
}
