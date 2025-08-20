import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/widget/custom_text_filed.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: CustomTextFiled(
        controller: messageController,
        hintText: 'what recipe do you want',
        obscureText: false,

        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.send, color: appWhiteColor),
        ),
      ),
    );
  }
}
