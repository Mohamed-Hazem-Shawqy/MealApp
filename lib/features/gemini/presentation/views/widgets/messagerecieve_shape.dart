import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class MessageRecieveShape extends StatelessWidget {
  const MessageRecieveShape({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
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
            Expanded(
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
                child: Text(message, style: TextStyle(color: appWhiteColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
