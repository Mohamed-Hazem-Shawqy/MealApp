import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_card.dart';

import '../view_model/bloc/bloc_state.dart';
import '../view_model/bloc/taskBloc.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is FavoriteUpdated) {
          if (state.favorites.isEmpty) {
            return Center(child: Text("No favorites yet"));
          }
          return Scaffold(
            backgroundColor: appWhiteColor,
            body: ListView(
              children: state.favorites
                  .map(
                    (food) => CustomCard(
                      favorite: food.favorite,
                      imagePath: food.imagePath,
                      foodKind: food.foodKind,
                      foodName: food.foodName,
                      ingredients: food.ingredients,
                      time: food.time,
                      isFavorite: context.read<TaskBloc>().isFavorite(food),
                      onFavoritePressed: () {
                        context.read<TaskBloc>().toggleFavorite(food);
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        }
        return Center(child: Text("No favorites yet"));
      },
    );
  }
}
