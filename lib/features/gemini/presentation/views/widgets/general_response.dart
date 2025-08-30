import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class GeneralResponse extends StatelessWidget {
  const GeneralResponse({super.key, required this.generalMessage});
  final String generalMessage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: appBlueColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(generalMessage, style: TextStyle(color: appWhiteColor)),
      ),
    );
  }
}