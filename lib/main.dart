import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/productdetails/data/repositories/meal_repository_impl.dart';
import 'package:meal_app/features/productdetails/doamin/usecase/get_meal_details.dart';
import 'package:meal_app/features/productdetails/presention/bloc/meal_details_bloc.dart';
import 'package:meal_app/features/productdetails/presention/view/meal_details_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://omyiyekaabsoinwxwsic.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9teWl5ZWthYWJzb2lud3h3c2ljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQzMjc5NTgsImV4cCI6MjA2OTkwMzk1OH0.ImW998tI6KGPkz_W13kXtIG2ZeYSScWqH_OZJbz9SNk',
  );

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.signedIn) {
      // Do something when user signs in
    }
  });

  final mealRepository = MealRepositoryImpl();
  final getMealDetails = GetMealDetails(mealRepository);

  runApp(MyApp(getMealDetails: getMealDetails));
}

class MyApp extends StatelessWidget {
  final GetMealDetails getMealDetails;
  const MyApp({super.key, required this.getMealDetails});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuhtCubit()),
        BlocProvider(create: (_) => MealDetailsBloc(getMealDetails)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: appBlueColor,
          textTheme: ThemeData.light().textTheme.apply(fontFamily: 'inter'),
        ),

        home: const MealDetailsPage(mealId: '1'),
      ),
    );
  }
}
