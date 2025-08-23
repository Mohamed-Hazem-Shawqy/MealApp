import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_fonts.dart';

import '../../../domain/entites/foodCategory.dart';
import '../../view_model/bloc/bloc_state.dart';
import '../../view_model/bloc/taskBloc.dart';

class CustomCard extends StatefulWidget {
  final String imagePath;
  final String foodKind;
  final String foodName;
  final String ingredients;
  final String time;
  final bool favorite;

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.foodKind,
    required this.foodName,
    required this.ingredients,
    required this.time,
    this.favorite = false,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.25,
              height: screenWidth * 0.25,
              child: Image.network(widget.imagePath),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.foodKind, style: AppFonts.textStyle13),
                  Text(widget.foodName, style: AppFonts.textStyle16),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: [
                      Text(widget.ingredients, style: AppFonts.textStyle13),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        "${widget.time}:Minutes",
                        style: AppFonts.textStyle16,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final bloc = context.read<TaskBloc>();
                  final food = Food(
                    foodName: widget.foodName,
                    imagePath: widget.imagePath,
                    foodKind: widget.foodKind,
                    ingredients: widget.ingredients,
                    time: widget.time,
                  );
                  final isFavorite = bloc.isFavorite(food);

                  return Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: appBlueColor,
                  );
                },
              ),
              iconSize: screenWidth * 0.07,
              onPressed: () {
                final bloc = context.read<TaskBloc>();
                final food = Food(
                  foodName: widget.foodName,
                  imagePath: widget.imagePath,
                  foodKind: widget.foodKind,
                  ingredients: widget.ingredients,
                  time: widget.time,
                );
                bloc.toggleFavorite(food);
              },
            ),
          ],
        ),
      ),
    );
  }
}
