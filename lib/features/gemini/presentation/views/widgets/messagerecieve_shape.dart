import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class MessageRecieveShape extends StatelessWidget {
  const MessageRecieveShape({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    log('rebuild MessageRecieveShape');
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              height: 30,
              child: Image.asset(
                'assets/images/poot.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: screenHeight / 3,
                    width: screenWidth / 3,
                    child: Image.asset(
                      'assets/images/onboardingimages/well-done-steak-homemade-potatoes 1@2x.png',
                    ),
                  ),
                  Text(message, style: TextStyle(color: appBlueColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
