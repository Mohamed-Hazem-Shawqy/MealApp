import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/productdetails/presention/view/widgets/directions_tab.dart';
import 'package:meal_app/features/productdetails/presention/view/widgets/ingredients_tab.dart';
import 'package:meal_app/features/productdetails/presention/view/widgets/summary_tab.dart';
import '../bloc/meal_details_bloc.dart';
import '../bloc/meal_details_event.dart';
import '../bloc/meal_details_state.dart';

class MealDetailsPage extends StatefulWidget {
  final String mealId;
  const MealDetailsPage({super.key, required this.mealId});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<MealDetailsBloc>().add(LoadMealDetails(widget.mealId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/onboardingimages/heart (1).png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<MealDetailsBloc, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MealDetailsLoaded) {
            final meal = state.meal;
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(meal.imageUrl, fit: BoxFit.cover),
                ),
                Text(
                  meal.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${meal.category} • ${meal.cookingTime}min • ${meal.servings} serving",
                ),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Summary"),
                    Tab(text: "Ingredients"),
                    Tab(text: "Direction"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SummaryTab(meal: meal),
                      IngredientsTab(meal: meal),
                      DirectionsTab(meal: meal),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MealDetailsError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
