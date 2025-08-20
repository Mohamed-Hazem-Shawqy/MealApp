import 'package:go_router/go_router.dart';
import 'package:meal_app/features/auth/presentation/view/login.dart';
import 'package:meal_app/features/auth/presentation/view/signup.dart';
import 'package:meal_app/features/home/presentation/view/home_screen.dart';
import 'package:meal_app/features/onboarding/onboarding_screen_two.dart';
import 'package:meal_app/features/onboarding/onboarding_screenone.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppRoutes {
  static const kLogin = '/';
  static const kHome = '/home';
  static const kSignup = '/signup';
  static const kOnboardingScreenOne = '/OnboardingScreenOne';
  static const kOnboardingScreenTwo = '/OnboardingScreenTwo';

  static final router = GoRouter(
    redirect: (context, state) {
      final bool loginRoute = state.uri.path == kLogin;
      final bool signupRoute = state.uri.path == kSignup;
      final bool onBordaingOneRoute = state.uri.path == kOnboardingScreenOne;
      final bool onBoardingSTwoRoute = state.uri.path == kOnboardingScreenTwo;

      final bool homeRoute = state.uri.path == kHome;
      final bool isLoggedIn =
          Supabase.instance.client.auth.currentSession != null;

      if (!isLoggedIn) {
        print('========================notlogin================');
        if (loginRoute||signupRoute||onBordaingOneRoute||onBoardingSTwoRoute) {
          return null;
        }
        return kLogin;
      }

      if (isLoggedIn) {
        print('========================login================');
        if (homeRoute) {
          return null;
        }
        return kHome;
      }
      return null;
    },
    routes: [
      GoRoute(path: kLogin, builder: (context, state) => const Login()),
      GoRoute(path: kSignup, builder: (context, state) => const Signup()),
      GoRoute(path: kHome, builder: (context, state) => HomeScreen()),
      GoRoute(path: kOnboardingScreenOne, builder: (context, state) => OnboardingScreenOne()),
      GoRoute(path: kOnboardingScreenTwo, builder: (context, state) => OnboardingScreenTwo()),
    ],
  );
}
