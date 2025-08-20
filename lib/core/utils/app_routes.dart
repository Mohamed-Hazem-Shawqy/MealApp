import 'package:go_router/go_router.dart';
import 'package:meal_app/core/widget/nav_bar.dart';
import 'package:meal_app/features/auth/presentation/view/login.dart';
import 'package:meal_app/features/auth/presentation/view/signup.dart';
import 'package:meal_app/features/gemini/presentation/views/chat_page.dart';
import 'package:meal_app/features/home/presentation/view/profile_screen.dart';
import 'package:meal_app/features/onboarding/onboarding_screen_two.dart';
import 'package:meal_app/features/onboarding/onboarding_screenone.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppRoutes {
  static const kLogin = '/';
  static const kCustomNav = '/CustomNav';
  static const kSignup = '/signup';
  static const kOnboardingScreenOne = '/OnboardingScreenOne';
  static const kOnboardingScreenTwo = '/OnboardingScreenTwo';
  static const kChatPage = '/ChatPage';
  static const kProfileScreen = '/ProfileScreen';

  static final router = GoRouter(
    redirect: (context, state) {
      // final bool loginRoute = state.uri.path == kLogin;
      // final bool signupRoute = state.uri.path == kSignup;
      // final bool onBordaingOneRoute = state.uri.path == kOnboardingScreenOne;
      // final bool onBoardingSTwoRoute = state.uri.path == kOnboardingScreenTwo;
      // final bool profileScreenRoute = state.uri.path == kProfileScreen;

      // final bool homeRoute = state.uri.path == kCustomNav;
      final publicRoutes = {
        kLogin,
        kSignup,
        kOnboardingScreenOne,
        kOnboardingScreenTwo,
      };

      final path = state.uri.path;

      final bool isLoggedIn =
          Supabase.instance.client.auth.currentSession != null;

      if (!isLoggedIn && !publicRoutes.contains(path)) {
        print('========================notlogin================');

        return kLogin;
      }

      if (isLoggedIn && publicRoutes.contains(path)) {
        print('========================login================');

        return kCustomNav;
      }
      return null;
    },
    routes: [
      GoRoute(path: kLogin, builder: (context, state) => const Login()),
      GoRoute(path: kSignup, builder: (context, state) => const Signup()),
      GoRoute(path: kCustomNav, builder: (context, state) => CustomNav()),
      GoRoute(
        path: kOnboardingScreenOne,
        builder: (context, state) => OnboardingScreenOne(),
      ),
      GoRoute(
        path: kOnboardingScreenTwo,
        builder: (context, state) => OnboardingScreenTwo(),
      ),
      GoRoute(path: kChatPage, builder: (context, state) => ChatPage()),
      GoRoute(
        path: kProfileScreen,
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
}
