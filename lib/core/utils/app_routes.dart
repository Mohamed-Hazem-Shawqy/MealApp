import 'package:go_router/go_router.dart';
import 'package:meal_app/core/widget/nav_bar.dart';
import 'package:meal_app/features/auth/presentation/view/login.dart';
import 'package:meal_app/features/auth/presentation/view/signup.dart';
import 'package:meal_app/features/gemini/data/model.dart';
import 'package:meal_app/features/gemini/presentation/views/chat_page.dart';
import 'package:meal_app/features/profile/presention/view/profile_screen.dart';
import 'package:meal_app/features/onboarding/onboarding_screen_two.dart';
import 'package:meal_app/features/onboarding/onboarding_screenone.dart';
import 'package:meal_app/features/productdetails/presention/view/meal_details_page.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppRoutes {
  static const kLogin = '/Login';
  static const kCustomNav = '/CustomNav';
  static const kSignup = '/signup';
  static const kOnboardingScreenOne = '/';
  static const kOnboardingScreenTwo = '/OnboardingScreenTwo';
  static const kChatPage = '/ChatPage';
  static const kProfileScreen = '/ProfileScreen';
  static const kMealDetailsPage = '/MealDetailsPage';

  static final router = GoRouter(
    redirect: (context, state) {
     
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
      GoRoute(
        path: kMealDetailsPage,
        builder: (context, state) {
          final GeminiResponseShapeModel response =state.extra as GeminiResponseShapeModel;
          return MealDetailsPage(mealId: '1',geminiResponseShapeModel:response ,);
        },
      ),
    ],
  );
}
