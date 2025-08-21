import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/widget/custom_text_filed.dart';
import 'package:meal_app/features/gemini/presentation/view_model/gemini_bloc/gemini_bloc.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_message_bloc/user_bloc.dart';

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
          onPressed: () {
            context.read<UserBloc>().add(
              UserSendEvent(userMessage: messageController.text),
            );
            context.read<GeminiBloc>().add(
              GeminiRsponseEvent(response: messageController.text),
            );

            messageController.clear();
          },
          icon: const Icon(Icons.send, color: appWhiteColor),
        ),
      ),
    );
  }
}
