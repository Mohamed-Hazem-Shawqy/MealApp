import 'package:flutter/material.dart';
import 'package:meal_app/features/home/domain/entites/foodCategory.dart';

class CustomSearch extends StatelessWidget {
  final List<Food> foods;
  final SearchController searchController;

  const CustomSearch({
    super.key,
    required this.foods,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: "Search recipes",
      searchController: searchController,
      suggestionsBuilder: (context, controller) {
        final input = controller.value.text;
        final filtered = foods
            .where((f) => f.foodName.toLowerCase().contains(input.toLowerCase()))
            .toList();

        return List<Widget>.generate(filtered.length, (index) {
          final food = filtered[index];
          return ListTile(
            title: Text(food.foodName),
            onTap: () {
              controller.closeView(food.foodName);
            },
          );
        });
      },
    );
  }
}
