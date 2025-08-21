import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class OnGeminiLoadinUI extends StatelessWidget {
  const OnGeminiLoadinUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 30,
            child: Image.asset(
              'assets/images/poot.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              color: appBlueColor,
              strokeWidth: 3,
              strokeAlign: 1,
            ),
          ),
        ],
      ),
    );
  }
}
