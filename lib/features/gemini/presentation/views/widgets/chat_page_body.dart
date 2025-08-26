import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meal_app/core/bloc/gemini_bloc/gemini_bloc.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_message_bloc/user_bloc.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/general_response.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagerecieve_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagesend_shape.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/on_loading%20.dart';

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
                      geministate.geminiResponse[index].isGeneral
                          ? GeneralResponse(
                              generalMessage:
                                  geministate.geminiResponse[index].general,
                            )
                          : MessageRecieveShape(
                              image: geministate.geminiResponse[index].image,
                              repoImpl: RepoImpl(),
                              ingrediantes: geministate
                                  .geminiResponse[index]
                                  .ingrediantes,
                              direction:
                                  geministate.geminiResponse[index].direction,
                              time: geministate.geminiResponse[index].time,
                              message:
                                  geministate.geminiResponse[index].mealName,
                              summary:
                                  geministate.geminiResponse[index].summary,
                              portien:
                                  geministate.geminiResponse[index].portien,
                              carp: geministate.geminiResponse[index].carp,
                              fat: geministate.geminiResponse[index].fat,
                              kcal: geministate.geminiResponse[index].kcal,
                              vetaimenes:
                                  geministate.geminiResponse[index].vetaimenes,
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
