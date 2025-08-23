import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meal_app/features/gemini/presentation/view_model/gemini_bloc/gemini_bloc.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_message_bloc/user_bloc.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagerecieve_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagesend_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/on_loading%20.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_card.dart';

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({
    super.key,
    required this.repoImpl,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final RepoImpl repoImpl;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (previous, current) {
        return current is UserSendMessage;
      },
      builder: (context, userstate) {
        return BlocBuilder<GeminiBloc, GeminiState>(
          buildWhen: (previous, current) {
            return current is GeminiRecieveResponse || current is GeminiLoading;
          },
          builder: (context, geministate) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              repoImpl.scrollToBottom(_scrollController);
            });
            if (userstate.usermessage.isEmpty) {
              return Center(
                child: Text(
                  "Start Chat",
                  style: TextStyle(color: appBlueColor, fontSize: 18),
                ),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: userstate.usermessage.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MessageSendShape(message: userstate.usermessage[index]),

                    if (geministate is GeminiRecieveResponse &&
                        index < geministate.geminiResponse.length)
                      geministate.isMeal
                          ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CustomCard(
                                foodKind: '',
                                imagePath: geministate.imageUrl ?? "https://img.spoonacular.com/recipes/632812-312x231.jpg",
                                foodName: 'Yousef',
                                ingredients: '',
                                time: '12',
                              ),
                          )
                          : MessageRecieveShape(
                              message: geministate.geminiResponse[index],
                            )
                    else if (index == userstate.usermessage.length - 1 &&
                        geministate is GeminiLoading)
                      const OnGeminiLoadinUI()
                    else if (geministate is GeminiError)
                      Text(
                        geministate.errMessage,
                        style: TextStyle(color: appBlueColor),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
