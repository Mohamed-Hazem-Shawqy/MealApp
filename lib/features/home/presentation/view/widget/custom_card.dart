import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_fonts.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String foodKind;
  final String foodName;
  final String ingredients;
  final String time;
  final bool favorite;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.foodKind,
    required this.foodName,
    required this.ingredients,
    required this.time,
    this.favorite = false,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imagePath,
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
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
                  Text(foodKind, style: AppFonts.textStyle13),
                  Text(foodName, style: AppFonts.textStyle16),
                  Text(ingredients, style: AppFonts.textStyle13),
                  Text('$time min', style: AppFonts.textStyle13),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : appBlueColor,
              ),
              onPressed: onFavoritePressed,
            ),
          ],
        ),
      ),
    );
  }
}
