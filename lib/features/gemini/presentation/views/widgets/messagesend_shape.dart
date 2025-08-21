import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/presentation/view_model/user_bloc/user_bloc.dart';

class MessageSendShape extends StatelessWidget {
  const MessageSendShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
      child: Align(
        alignment: Alignment.bottomRight,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserSendMessage) {
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: appBlueColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  state.usermessage,
                  style: TextStyle(color: appWhiteColor),
                ),
              );
            } else {
              return Text('', style: TextStyle(color: appWhiteColor));
            }
          },
        ),
      ),
    );
  }
}
