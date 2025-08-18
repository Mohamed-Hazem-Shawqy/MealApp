import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/onboarding/onboarding_screenone.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://omyiyekaabsoinwxwsic.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9teWl5ZWthYWJzb2lud3h3c2ljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQzMjc5NTgsImV4cCI6MjA2OTkwMzk1OH0.ImW998tI6KGPkz_W13kXtIG2ZeYSScWqH_OZJbz9SNk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuhtCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: appBlueColor,
          textTheme: ThemeData.light().textTheme.apply(fontFamily: 'inter'),
        ),
        home: const OnboardingScreenOne(),
      ),
    );
  }
}
