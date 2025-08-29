import 'package:flutter/material.dart';
import 'package:meal_app/features/gemini/data/model.dart';

class DirectionsTab extends StatelessWidget {
  final GeminiResponseShapeModel geminiResponseShapeModel;
  const DirectionsTab({super.key, required this.geminiResponseShapeModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: geminiResponseShapeModel.direction.length,
      itemBuilder: (context, index) {
        final step = geminiResponseShapeModel.direction[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${index + 1}. ", style: const TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(step),
              ),
            ],
          ),
        );
      },
    );
  }
}
