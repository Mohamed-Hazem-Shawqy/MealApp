import 'package:go_router/go_router.dart';
import 'package:meal_app/features/auth/presentation/view/login.dart';
import 'package:meal_app/features/auth/presentation/view/signup.dart';
import 'package:meal_app/features/home/presentation/view/home.dart';

abstract class AppRoutes {
  static const kLogin = '/';
  static const kHome = '/home';
  static const kSignup = '/signup';

  static final router = GoRouter(
    routes: [
      GoRoute(path: kLogin, builder: (context, state) => const Login()),
      GoRoute(path: kSignup, builder: (context, state) => const Signup()),
      GoRoute(path: kHome, builder: (context, state) => const Home()),
    ],
  );
}
