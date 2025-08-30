import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meal_app/core/function/bloc_observer.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/core/bloc/gemini_bloc/gemini_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:meal_app/features/productdetails/data/repositories/meal_repository_impl.dart';
import 'package:meal_app/features/productdetails/doamin/usecase/get_meal_details.dart';
import 'package:meal_app/features/productdetails/presention/bloc/meal_details_bloc.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/home/presentation/view_model/bloc/taskBloc.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  await dotenv.load(fileName: 'api_key.env');
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  await Supabase.initialize(
    url: 'https://omyiyekaabsoinwxwsic.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9teWl5ZWthYWJzb2lud3h3c2ljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQzMjc5NTgsImV4cCI6MjA2OTkwMzk1OH0.ImW998tI6KGPkz_W13kXtIG2ZeYSScWqH_OZJbz9SNk',
  );

 

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

        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => MealDetailsBloc(getMealDetails)),
        BlocProvider(create: (_) => GeminiBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          textTheme: ThemeData.light().textTheme.apply(fontFamily: 'inter'),
        ),

        routerConfig: AppRoutes.router,
      ),
    );
  }
}
