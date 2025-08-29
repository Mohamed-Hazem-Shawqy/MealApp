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
  final List<String> ingredients;
  final List<String> direction;
  final String time;
  final bool favorite;
  final int portien;
  final int carp;
  final int fat;
  final int kcal;
  final int vetaimenes;

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.foodKind,
    required this.foodName,
    required this.ingredients,
    required this.direction,
    required this.time,
    this.favorite = false,
    required this.portien,
    required this.carp,
    required this.fat,
    required this.kcal,
    required this.vetaimenes,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.imagePath,
                width: screenWidth * 0.30,
                height: screenWidth * 0.25,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/placeholder.png',
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.foodName, style: AppFonts.textStyle16),
                  Text(
                    widget.foodKind,
                    style: AppFonts.textStyle13,
                    maxLines: 2,
                  ),
                  SizedBox(height: screenHeight * 0.005),

                  // SizedBox(height: screenHeight * 0.005),
                  // Row(
                  //   children: List.generate(
                  //     5,
                  //     (index) => Icon(
                  //       Icons.star,
                  //       color: Colors.orangeAccent,
                  //       size: screenWidth * 0.05,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            IconButton(
              icon: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final bloc = context.read<TaskBloc>();
                  final food = Food(
                    portien: widget.portien,
                    vetaimenes: widget.vetaimenes,
                    kcal: widget.kcal,
                    carp: widget.carp,
                    fat: widget.fat,
                    foodName: widget.foodName,
                    imagePath: widget.imagePath,
                    foodKind: widget.foodKind,
                    ingredients: widget.ingredients,
                    direction: widget.direction,
                    time: widget.time,
                  );
                  final isFavorite = bloc.isFavorite(food);

                  return Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Colors.red,
                    //color: appBlueColor,
                  );
                },
              ),
              iconSize: screenWidth * 0.07,
              onPressed: () {
                final bloc = context.read<TaskBloc>();
                final food = Food(
                  portien: widget.portien,
                  vetaimenes: widget.vetaimenes,
                  kcal: widget.kcal,
                  carp: widget.carp,
                  fat: widget.fat,
                  foodName: widget.foodName,
                  imagePath: widget.imagePath,
                  foodKind: widget.foodKind,
                  ingredients: widget.ingredients,
                  direction: widget.direction,
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
