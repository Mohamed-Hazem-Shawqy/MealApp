import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class MessageRecieveShape extends StatelessWidget {
  final String image;
  final List<String> ingrediantes;
  final String direction;
  final String time;
  final String message;
  final String summary;
  final String protein;
  final String carp;
  final String fat;
  final String kcal;
  final String vetaimenes;

  const MessageRecieveShape({
    super.key,
    required this.image,
    required this.ingrediantes,
    required this.direction,
    required this.time,
    required this.message,
    required this.summary,
    required this.protein,
    required this.carp,
    required this.fat,
    required this.kcal,
    required this.vetaimenes,
  });

  void addFoodToHome() {
    // TODO: implement logic
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  image,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(summary, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Text('⏳ Ready in $time min'),
            const SizedBox(height: 4),
            Text('🍽 Portion: $protein'),
            const SizedBox(height: 4),
            Text('🥖 Carbs: $carp | 🥩 Fat: $fat | 🔥 $kcal kcal'),
            const SizedBox(height: 4),
            Text('💊 Vitamins: $vetaimenes'),
            const Divider(height: 20),
            Text('📝 Ingredients:\n- ${ingrediantes.join('\n- ')}'),
            const SizedBox(height: 8),
            Text('👨‍🍳 Directions:\n$direction'),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBlueColor,
                  ),
                  onPressed: addFoodToHome,
                  child: const Text("Add to Home"),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/mealDetails'),
                  child: const Text("Open Details"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
