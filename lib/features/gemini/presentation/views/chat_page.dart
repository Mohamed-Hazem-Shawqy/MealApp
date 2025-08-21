import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meal_app/features/gemini/presentation/view_model/gemini_bloc/gemini_bloc.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_message_bloc/user_bloc.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/input_field.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagerecieve_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagesend_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/on_loading%20.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  RepoImpl repoImpl = RepoImpl();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              child: BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) {
                  return current is UserSendMessage;
                },
                builder: (context, userstate) {
                  return BlocBuilder<GeminiBloc, GeminiState>(
                    buildWhen: (previous, current) {
                      return current is GeminiRecieveResponse ||
                          current is GeminiLoading;
                    },
                    builder: (context, geministate) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        repoImpl.scrollToBottom(_scrollController);
                      });
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: userstate.usermessage.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              if (userstate is UserSendMessage)
                                MessageSendShape(
                                  message: userstate.usermessage[index],
                                ),

                              if (geministate is GeminiRecieveResponse &&
                                  index < geministate.geminiResponse.length)
                                MessageRecieveShape(
                                  message: geministate.geminiResponse[index],
                                )
                              else if (index ==
                                      userstate.usermessage.length - 1 &&
                                  geministate is GeminiLoading)
                                const OnGeminiLoadinUI()
                              else if (geministate is GeminiError)
                                Text(
                                  geministate.errMessage,
                                  style: TextStyle(color: appWhiteColor),
                                )
                              else
                                Center(
                                  child: Text(
                                    'Start Chat',
                                    style: TextStyle(color: appWhiteColor),
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            const InputField(),
          ],
        ),
      ),
    );
  }
}
