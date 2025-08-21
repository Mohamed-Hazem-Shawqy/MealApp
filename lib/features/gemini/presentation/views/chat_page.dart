import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/presentation/view_model/gemini_bloc/gemini_bloc.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_bloc/user_bloc.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/input_field.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagerecieve_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagesend_shape.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = "ChatPage";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GeminiBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: Scaffold(
        backgroundColor: appWhiteColor,
        appBar: AppBar(title: const Text("Chat page")),

        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [MessageSendShape(), MessageRecieveShape()],
              ),
            ),
            const InputField(),
          ],
        ),
      ),
    );
  }
}
