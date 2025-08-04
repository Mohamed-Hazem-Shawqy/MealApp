import 'package:go_router/go_router.dart';
import 'package:meal_app/features/auth/presentation/view/login.dart';

abstract class AppRoutes {
  static const kLogin = '/';

  static final router = GoRouter(
    routes: [GoRoute(path: kLogin, builder: (context, state) => const Login(),
    
    
    ),
    
    
    ],
  );
}
