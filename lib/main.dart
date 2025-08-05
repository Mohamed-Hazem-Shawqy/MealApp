import 'package:flutter/material.dart';
import 'package:meal_app/features/onboarding/onboarding_screenone.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'inter'),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: OnboardingScreenOne(),
      ),
    );
  }
}
