import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_message_bloc/user_bloc.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/chat_page_body.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/input_field.dart';

import '../view_model/gemini_bloc/gemini_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final RepoImpl repoImpl = RepoImpl();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => GeminiBloc(repoImpl)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("AI Chat"),
          backgroundColor: appBlueColor,
          foregroundColor: appWhiteColor,
        ),
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            Expanded(
              child: ChatPageBody(
                repoImpl: repoImpl,
                scrollController: _scrollController,
              ),
            ),
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: const InputField(),
            ),
          ],
        ),
      ),
    );
  }
}
