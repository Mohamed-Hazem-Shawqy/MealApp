import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class CustomTextFiledLight extends StatelessWidget {
  const CustomTextFiledLight({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    required this.obscureText,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: appBlueColor,
      style: TextStyle(color: appBlueColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: appBlueColor),
        prefixIcon: prefixIcon,
        fillColor: Colors.white,
        prefixIconColor: appBlueColor,
        filled: true,
        suffixIcon: suffixIcon,

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appBlueColor),
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
          borderSide: BorderSide(color: appBlueColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appBlueColor),
        ),
      ),
    );
  }
}
