import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/home/domain/entites/foodCategory.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/bloc_event.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/bloc_state.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/taskBloc.dart';

class MessageRecieveShape extends StatelessWidget {
  const MessageRecieveShape({
    super.key,
    required this.message,
    required this.summary, required this.time,
  });
  final String message;
  final String summary;
  final String time;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    log('rebuild MessageRecieveShape');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          height: 30,
          child: Image.asset('assets/images/poot.jpg', fit: BoxFit.fitWidth),
        ),

        Expanded(
          child: Card(
            child: BlocListener<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is TaskLoaded) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Recibe added to home')),
                  );
                }
              },
              child: Row(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight / 6,
                    width: screenWidth / 3,
                    child: Image.asset(
                      'assets/images/onboardingimages/well-done-steak-homemade-potatoes 1@2x.png',
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "$message: It's $summary",
                      style: TextStyle(color: appBlueColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: screenHeight / 9),
                    child: TextButton(
                      onPressed: () {
                        final newfood = Food(
                          imagePath:
                              'https://img.spoonacular.com/recipes/632812-312x231.jpg',
                          foodKind: summary,
                          foodName: message,
                          ingredients: '',
                          time:time ,
                        );
                        context.read<TaskBloc>().add(AddfoodToHome(newfood));
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
