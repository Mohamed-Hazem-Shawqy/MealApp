import 'package:flutter/material.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/input_field.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagerecieve_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagesend_shape.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat page")),

      body: Column(
        children: [
          MessageRecieveShape(),
          MessageSendShape(),
          Spacer(),
          const InputField(),
        ],
      ),
    );
  }
}
