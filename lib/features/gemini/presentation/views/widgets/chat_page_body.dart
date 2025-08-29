import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/general_response.dart';
import 'package:meal_app/features/gemini/presentation/views/widgets/messagerecieve_shape.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_message_bloc/user_bloc.dart';
import 'package:meal_app/features/gemini/presentation/view_model/gemini_bloc/gemini_bloc.dart';

import 'on_loading .dart';

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
      buildWhen: (previous, current) => current is UserSendMessage,
      builder: (context, userstate) {
        return BlocBuilder<GeminiBloc, GeminiState>(
          buildWhen: (previous, current) =>
              current is GeminiRecieveResponse ||
              current is GeminiLoading ||
              current is GeminiError,
          builder: (context, geministate) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              repoImpl.scrollToBottom(_scrollController);
            });

            // Debug print
            print("🟢 User messages: ${userstate.usermessage}");
            print("🟡 Gemini state: $geministate");

            if (userstate.usermessage.isEmpty) {
              return const Center(child: Text("Start Chat"));
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: userstate.usermessage.length,
              itemBuilder: (context, index) {
                final isLoading = geministate is GeminiLoading;
                final isData = geministate is GeminiRecieveResponse;
                final isError = geministate is GeminiError;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // رسالة اليوزر
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(userstate.usermessage[index]),
                      ),
                    ),

                    // رد Gemini
                    if (isData &&
                        index <
                            (geministate as GeminiRecieveResponse)
                                .geminiResponse
                                .length)
                      (() {
                        final item = geministate.geminiResponse[index];
                        if (item.isGeneral) {
                          return GeneralResponse(generalMessage: item.message);
                        }
                        return MessageRecieveShape(
                          image: item.image,
                          ingrediantes: item.ingrediantes,
                          direction: item.direction,
                          time: item.time,
                          message: item.message,
                          summary: item.summary,
                          protein: item.protein,
                          carp: item.carp,
                          fat: item.fat,
                          kcal: item.kcal,
                          vetaimenes: item.vetaimenes,
                        );
                      }()),

                    // حالة التحميل
                    if (isLoading) const OnLoadingWidget(),

                    // حالة الخطأ
                    if (isError)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "❌ Error: ${(geministate as GeminiError).message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
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
