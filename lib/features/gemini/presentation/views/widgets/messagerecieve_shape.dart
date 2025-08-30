import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:meal_app/features/gemini/data/model.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meal_app/features/home/domain/entites/foodCategory.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/bloc_event.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/bloc_state.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/taskBloc.dart';

class MessageRecieveShape extends StatelessWidget {
  const MessageRecieveShape({
    super.key,
    required this.message,
    required this.summary,
    required this.time,
    required this.portien,
    required this.carp,
    required this.fat,
    required this.kcal,
    required this.vetaimenes,
    required this.ingrediantes,
    required this.direction,
    required this.repoImpl,
    required this.image,
  });
  final String message;
  final String summary;
  final String time;
  final String image;

  final int portien;
  final int carp;
  final int fat;
  final int kcal;
  final int vetaimenes;
  final List<String> ingrediantes;
  final List<String> direction;

  final RepoImpl repoImpl;

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
          child: BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskLoaded) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Recibe added to home')));
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  final geminiResponse = GeminiResponseShapeModel(
                    general: "",
                    mealName: message,
                    summary: summary,
                    ingrediantes: ingrediantes,
                    direction: direction,
                    portien: portien,
                    carp: carp,
                    fat: fat,
                    kcal: kcal,
                    vetaimenes: vetaimenes,
                    time: time,
                    image: image,
                  );

                  GoRouter.of(
                    context,
                  ).push(AppRoutes.kMealDetailsPage, extra: geminiResponse);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        child: Image.network(
                          image,
                          height: screenHeight / 6,
                          width: screenWidth / 3,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/onboardingimages/well-done-steak-homemade-potatoes 1@2x.png',
                              height: screenHeight / 6,
                              width: screenWidth / 3,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),

                     
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // اسم الأكلة
                              Text(
                                message,
                                style: TextStyle(
                                  color: appBlueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                            
                              Text(
                                summary,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 10),

                       
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () {
                                    final newfood = Food(
                                      imagePath: image,
                                      foodKind: summary,
                                      foodName: message,
                                      ingredients: ingrediantes,
                                      direction: direction,
                                      time: time,
                                      portien: portien,
                                      vetaimenes: vetaimenes,
                                      kcal: kcal,
                                      carp: carp,
                                      fat: fat,
                                    );
                                    context.read<TaskBloc>().add(
                                      AddfoodToHome(newfood),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
