import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/widget/nav_bar.dart';
import 'package:meal_app/features/auth/presentation/view/login.dart';
import 'package:meal_app/features/auth/presentation/view/signup.dart';
import 'package:meal_app/features/home/presentation/view/home_screen.dart';
import 'package:meal_app/features/onboarding/onboarding_screen_two.dart';
import 'package:meal_app/features/onboarding/onboarding_screenone.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/presentation/view/widget/ChangePasswordScreen.dart';
import '../../features/home/presentation/view/widget/ResetPasswordScreen.dart';
import '../../features/onboarding/OnboardingScreenFour.dart';
import '../../features/onboarding/OnboardingScreenThree.dart';

abstract class AppRoutes {
  static const kLogin = '/';
  static const kHome = '/home';
  static const kSignup = '/signup';
  static const kOnboardingScreenOne = '/OnboardingScreenOne';
  static const kOnboardingScreenTwo = '/OnboardingScreenTwo';
  static const kOnboardingScreenThree = '/OnboardingScreenThree';
  static const kOnboardingScreenFour = '/OnboardingScreenFour';
  static const kNav = '/nav';
  static const kResetPassword = '/reset-password';
  static const kChangePassword = '/change-password';

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_launch') ?? true;
  }

  static Future<void> setFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);
  }

  static final router = GoRouter(
    initialLocation: kOnboardingScreenOne,
    redirect: (BuildContext context, GoRouterState state) async {
      final bool loginRoute = state.uri.path == kLogin;
      final bool signupRoute = state.uri.path == kSignup;
      final bool onBoardingOneRoute = state.uri.path == kOnboardingScreenOne;
      final bool onBoardingTwoRoute = state.uri.path == kOnboardingScreenTwo;
      final bool onBoardingThreeRoute =
          state.uri.path == kOnboardingScreenThree;
      final bool onBoardingFourRoute = state.uri.path == kOnboardingScreenFour;
      final bool resetPasswordRoute = state.uri.path == kResetPassword;
      final bool changePasswordRoute = state.uri.path == kChangePassword;

      final bool isLoggedIn =
          Supabase.instance.client.auth.currentSession != null;
      final bool isFirst = await isFirstLaunch();

      print(
        'Current route: ${state.uri.path}, isLoggedIn: $isLoggedIn, isFirst: $isFirst',
      );

      if (isFirst && !isLoggedIn) {
        print('========================notlogin================');
        if (onBoardingOneRoute ||
            onBoardingTwoRoute ||
            onBoardingThreeRoute ||
            onBoardingFourRoute) {
          return null;
        }
        return kOnboardingScreenOne;
      }

      if (!isLoggedIn) {
        print('========================notlogin================');
        if (loginRoute ||
            signupRoute ||
            resetPasswordRoute ||
            changePasswordRoute) {
          return null;
        }
        return kLogin;
      }

      print('========================login================');
      if (state.uri.path == kNav || state.uri.path == kHome) {
        return null;
      }
      return kNav;
    },
    routes: [
      GoRoute(path: kLogin, builder: (context, state) => const Login()),
      GoRoute(path: kSignup, builder: (context, state) => const Signup()),
      GoRoute(path: kHome, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: kOnboardingScreenOne,
        builder: (context, state) {
          setFirstLaunch(); // Mark onboarding as seen
          return OnboardingScreenOne();
        },
      ),
      GoRoute(
        path: kOnboardingScreenTwo,
        builder: (context, state) => OnboardingScreenTwo(),
      ),
      GoRoute(
        path: kOnboardingScreenThree,
        builder: (context, state) => OnboardingScreenThree(),
      ),
      GoRoute(
        path: kOnboardingScreenFour,
        builder: (context, state) => OnboardingScreenFour(),
      ),
      GoRoute(path: kNav, builder: (context, state) => CustomNav()),
      GoRoute(
        path: kResetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: kChangePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
    ],
  );
}
