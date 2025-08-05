import 'package:go_router/go_router.dart';
import 'package:meal_app/features/auth/presentation/view/login.dart';
import 'package:meal_app/features/home/presentation/view/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppRoutes {
  static const kLogin = '/';
  static const kHome = '/home';

  static final router = GoRouter(
    
      
  
    redirect: (context, state) {
      final bool loginRoute = state.uri.path == kLogin;
      final bool homeRoute = state.uri.path == kHome;
      final bool isLoggedIn =
          Supabase.instance.client.auth.currentSession != null;
      final bool isLoggedin2 =
          Supabase.instance.client.auth.currentUser != null;
          

      if (!isLoggedIn && !isLoggedin2) {
        print('========================notlogin================');
        if (loginRoute) {
          return null;
        }
        return kLogin;
      }
      if (isLoggedIn && isLoggedin2) {
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
      GoRoute(path: kHome, builder: (context, state) => const Home()),
    ],
  );
}
