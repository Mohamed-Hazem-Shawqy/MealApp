import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/presentation/view_model/gemini_bloc/gemini_bloc.dart';

class MessageRecieveShape extends StatelessWidget {
  const MessageRecieveShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: BlocBuilder<GeminiBloc, GeminiState>(
          builder: (context, state) {
            if (state is GeminiLoading) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    color: appBlueColor,
                    strokeWidth: 3,
                    strokeAlign: 1,
                  ),
                ),
              );
            } else if (state is GeminiRecieveResponse) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: Image.asset(
                      'assets/images/poot.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appBlueColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        state.geminiResponse,
                        style: TextStyle(color: appWhiteColor),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is GeminiError) {
              return Text(
                state.errMessage,
                style: TextStyle(color: appWhiteColor),
              );
            } else if (state is GeminiInitial) {
              return Text('', style: TextStyle(color: appWhiteColor));
            } else {
              return Text(
                'Something went wrong please try later',
                style: TextStyle(color: appWhiteColor),
              );
            }
          },
        ),
      ),
    );
  }
}
