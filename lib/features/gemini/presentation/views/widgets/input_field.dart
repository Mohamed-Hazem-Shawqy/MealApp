import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/gemini_bloc/gemini_bloc.dart';
import '../../view_model/user_message_bloc/user_bloc.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Type a message...'),
            onSubmitted: (_) => _send(context),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _send(context),
        ),
      ],
    );
  }

  void _send(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<UserBloc>().add(UserSendEvent(userMessage: text));

    context.read<GeminiBloc>().add(GeminiRsponseEvent(text));

    _controller.clear();
    FocusScope.of(context).unfocus();
  }
}
