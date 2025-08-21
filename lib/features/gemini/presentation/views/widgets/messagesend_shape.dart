import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class MessageSendShape extends StatelessWidget {
  const MessageSendShape({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    log('rebuild Message Send Shape');
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: appBlueColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Text(message, style: TextStyle(color: appWhiteColor)),
        ),
      ),
    );
  }
}
