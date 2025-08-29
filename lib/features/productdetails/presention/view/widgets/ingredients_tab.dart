import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/data/model.dart';

class IngredientsTab extends StatelessWidget {
  final GeminiResponseShapeModel geminiResponseShapeModel;
  const IngredientsTab({super.key, required this.geminiResponseShapeModel});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: geminiResponseShapeModel.ingrediantes.length,
      itemBuilder: (context, index) {
        final ingredient = geminiResponseShapeModel.ingrediantes[index];
        return ListTile(
          title: Text(
            ingredient,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 2,
        color: appBlueColor,
      ),
    );
  }
}
